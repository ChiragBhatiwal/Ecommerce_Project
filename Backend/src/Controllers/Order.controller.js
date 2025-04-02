const orderModel = require("../Models/Order.model");
const productModel = require("../Models/Product.model");
const userModel = require("../Models/User.model");
const addressModel = require("../Models/Address.model");
const { ObjectId } = require("mongodb");

const placingOrder = async (req, resp) => {

    const userId = req.user;

    if (!userId) {
        return resp.send("User Id is Required");
    }

    const { productId, addressId, quantity, paymentType, sellerId, totalBill } = req.body;

    if ([productId, addressId, paymentType, sellerId].some((field) => field?.trim() === "")) {
        return resp.send("All Field Required");
    }

    console.log(totalBill);

    if (!quantity && !totalBill) {
        return resp.send("Quantity And Bill Required");
    }

    const placeUserOrder = await orderModel.create({ userId: userId._id, productId, totalBill, sellerId, addressId, quantity, paymentType });

    if (!placeUserOrder) {
        return resp.send("Something Went Wrong While Placing Order");
    }

    return resp.status(200).json({ placeUserOrder });
}

const getProductDetailsForShowingInPreOrderProcessing = async (req, resp) => {

    const userId = req.user;

    if (!userId) {
        return resp.send("UserId is required");
    }

    const { key } = req.body;

    if (!key) {
        return resp.send("Key Is Required");
    }

    const matchCriteria = Array.isArray(key) ? { status: { $in: key } } : { status: key };

    const findOrdersOfUser = await orderModel.aggregate([
        {
            $match: { userId: new ObjectId(userId._id) }
        },
        {
            $match: matchCriteria
        },
        {
            $lookup: {
                from: "products",
                foreignField: "_id",
                localField: "productId",
                as: "ProductDetails"
            }
        },
        {
            $lookup: {
                from: "users",
                foreignField: "_id",
                localField: "userId",
                as: "UserDetails"
            }
        },
        {
            $lookup: {
                from: "addresses",
                foreignField: "_id",
                localField: "addressId",
                as: "AddressDetails"
            }
        },
        {
            $project: {
                quantity: 1, totalBill: 1, _id: 1, paymentType: 1, status: 1, productId: { $arrayElemAt: ["$ProductDetails._id", 0] },
                userId: { $arrayElemAt: ["$UserDetails._id", 0] },
                productName: { $arrayElemAt: ["$ProductDetails.productName", 0] }, productPrice: { $arrayElemAt: ["$ProductDetails.productPrice", 0] },
                username: { $arrayElemAt: ["$UserDetails.username", 0] }, userAddress: { $arrayElemAt: ["$AddressDetails.address", 0] },
                userCity: { $arrayElemAt: ["$AddressDetails.city", 0] }, userState: { $arrayElemAt: ["$AddressDetails.state", 0] },
                userPincode: { $arrayElemAt: ["$AddressDetails.pincode", 0] }
            }
        }
    ]);

    if (!findOrdersOfUser) {
        return resp.send("Something Went Wrong Didn't find Orders");
    }

    return resp.status(200).json(findOrdersOfUser);
}

const pricingOnTheBasesOfQuantityUpdate = async (req, resp) => {
    const { quantity } = req.body;

    if (!quantity) {
        return resp.send("Quantity Required");
    }

    const user = req.user;

    if (!user) {
        return resp.send("user id is required");
    }

    const productId = req.params;

    if (!productId) {
        return resp.send("Product Id is Required");
    }

    const product = await productModel.findById(productId._id);

    if (!product) {
        return resp.send("Product Not Found");
    }

    const userDetails = await userModel.findById(user._id).select("-password -refreshToken -LikedProduct -email");

    if (!userDetails) {
        return resp.send("User Not Found");
    }

    const findAddress = await addressModel.find({ user: user._id });

    if (!findAddress) {
        return resp.send("Address Not Found");
    }

    const productPrice = product.productPrice * quantity;

    const discountPercentage = product.discountOnProduct;

    const discountedPrice = (productPrice * discountPercentage) / 100;

    const chargesAndTax = product.taxOnProduct;

    const totalBill = (productPrice - discountedPrice) + chargesAndTax;

    const bill = {
        productPrice,
        discountPercentage,
        discountedPrice,
        chargesAndTax,
        totalBill
    }

    return resp.status(200).json({ product, username: userDetails.username, bill, findAddress });
}

const handleOrderStatusSocketEvents = (socket) => {

    socket.on("update-order-status", async (data) => {

        const orderUpdate = await orderModel.findByIdAndUpdate(data.orderId, {
            $set: {
                status: data.status
            }
        })

        const updateOrder = await orderModel.aggregate(
            [
                {
                    $match: { _id: new ObjectId(data.orderId) }
                },
                {
                    $lookup: {
                        from: "products",
                        foreignField: "_id",
                        localField: "productId",
                        as: "ProductDetails"
                    }
                },
                {
                    $lookup: {
                        from: "users",
                        foreignField: "_id",
                        localField: "userId",
                        as: "UserDetails"
                    }
                },
                {
                    $lookup: {
                        from: "addresses",
                        foreignField: "_id",
                        localField: "addressId",
                        as: "AddressDetails"
                    }
                },
                {
                    $project: {
                        quantity: 1, totalBill: 1, _id: 1, paymentType: 1, status: 1, productId: { $arrayElemAt: ["$ProductDetails._id", 0] },
                        userId: { $arrayElemAt: ["$UserDetails._id", 0] },
                        productName: { $arrayElemAt: ["$ProductDetails.productName", 0] }, productPrice: { $arrayElemAt: ["$ProductDetails.productPrice", 0] },
                        username: { $arrayElemAt: ["$UserDetails.username", 0] }, userAddress: { $arrayElemAt: ["$AddressDetails.address", 0] },
                        userCity: { $arrayElemAt: ["$AddressDetails.city", 0] }, userState: { $arrayElemAt: ["$AddressDetails.state", 0] },
                        userPincode: { $arrayElemAt: ["$AddressDetails.pincode", 0] }
                    }
                }
            ]
        );
        if (!updateOrder) {
            return console.log("Nothing Changes")
        }
        console.log(updateOrder);
        socket.emit("order-updated", updateOrder);
    })
}

const getOrderStatus = async (req, resp) => {

    const user = req.user;

    if (!user) {
        return resp.send("Token not Found");
    }

    try {
        const result = await orderModel.aggregate([
            {
                $match: { sellerId: new ObjectId(user._id) }
            },

            {
                $group: {
                    _id: {
                        $cond: [
                            { $eq: ["$status", "Delivered"] },
                            "Delivered",
                            {
                                $cond: [
                                    { $in: ["$status", ['Pending', 'Confirmed', 'Packed', 'Shipped']] },
                                    "Others",
                                    null
                                ]
                            }
                        ],
                    },
                    count: { $sum: 1 },
                    revenue: {
                        $sum: {
                            $cond: [
                                { $eq: ["$status", "Delivered"] },
                                "$totalBill",
                                0
                            ],
                        },
                    },
                },
            },
            {
                $match: { _id: { $ne: null } },
            },
            {
                $group: {
                    _id: null,
                    Delivered: {
                        $sum: {
                            $cond: [{ $eq: ["$_id", "Delivered"] }, "$count", 0],
                        },
                    },
                    Others: {
                        $sum: {
                            $cond: [{ $eq: ["$_id", "Others"] }, "$count", 0],
                        },
                    },
                    revenue: { $sum: "$revenue" },
                },
            },
            {
                $project: {
                    _id: 0,
                    Delivered: 1,
                    Others: 1,
                    revenue: 1,
                },
            },

        ]);

        resp.status(200).json({
            success: true,
            data: result[0] || { Delivered: 0, Others: 0, revenue: 0 },
        });
    } catch (error) {
        resp.status(500).json({
            success: false,
            message: "Failed to fetch order counts",
            error: error.message,
        });
    }
}

const getBuyAgainOrders = async (req, resp) => {
   
    const user = req.user;

    if (!user) {
        return resp.send("Token not Found");
    }


    const result = await orderModel.aggregate([
        {
            $match: {
                userId: new ObjectId(user._id),
                status: { $in: ["Delivered"] }
            }
        },
        {
            $lookup: {
                from: "products",
                foreignField: "_id",
                localField: "productId",
                as: "ProductDetails"
            }
        },
        {
            $addFields: {
                productDetails: { $arrayElemAt: ["$ProductDetails", 0] } // Extract first product object
            }
        },
        {
            $project: {
                productId: "$productDetails._id",
                productName: "$productDetails.productName",
                productImage: "$productDetails.productImage",
                productPrice:"$productDetails.productPrice",
                totalBill: 1,
                quantity: 1,
                paymentType: 1,
                status: 1,
                createdAt: 1
            }
        }
    ]);
    
    if (!result) {
        return resp.status(404).json({ "message": "Not Found" })
    }

    
        resp.status(200).json({ result });
    }

const getCurrentOrderedProductsList = async (req, resp) => {
   
    const user = req.user;

    if (!user) {
        return resp.send("Token not Found");
    }


    const result = await orderModel.aggregate([
        {
            $match: {
                userId: new ObjectId(user._id),
                status: { $in: ["Pending", "Confirmed", "Packed", "Shipped"] }
            }
        },
        {
            $lookup: {
                from: "products",
                foreignField: "_id",
                localField: "productId",
                as: "ProductDetails"
            }
        },
        {
            $addFields: {
                productDetails: { $arrayElemAt: ["$ProductDetails", 0] } // Extract first product object
            }
        },
        {
            $project: {
                productId: "$productDetails._id",
                productName: "$productDetails.productName",
                productImage: "$productDetails.productImage",
                productPrice:"$productDetails.productPrice",
                totalBill: 1,
                quantity: 1,
                paymentType: 1,
                status: 1,
                createdAt: 1
            }
        }
    ]);

    if (!result) {
        return resp.status(404).json({ message: "Error Something Went Wrong" })
    }

   return resp.status(200).json({result});
}

module.exports = { getCurrentOrderedProductsList, placingOrder, getProductDetailsForShowingInPreOrderProcessing, pricingOnTheBasesOfQuantityUpdate, handleOrderStatusSocketEvents, getOrderStatus, getBuyAgainOrders }