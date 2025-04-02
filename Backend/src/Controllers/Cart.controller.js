const cartModel = require("../Models/Cart.model")
const ApiError = require("../Utils/ApiError.util")
const ApiResponse = require("../Utils/ApiResponse.util")
const {ObjectId} = require("mongodb");

const addProductToCart = async (req, resp) => {
   try {
      const productId = req.params; 
      const userId = req.user;

      if (!productId) {
         return resp.status(400).json({ error: "Product ID is required" });
      }

      if (!userId) {
         return resp.status(401).json({ error: "User ID is required" });
      }

      const findIfItemIsAlreadyInCart = await cartModel.findOne({
         userId: userId._id,
         productId: productId._id,
      });

      if (findIfItemIsAlreadyInCart) {
         return resp.status(400).json({ error: "Item is already in the cart" });
      }

      const sendItemToCart = await cartModel.create({
         userId: userId._id,
         productId: productId._id,
      });

      if (!sendItemToCart) {
         return resp.status(500).json({ error: "Failed to add item to the cart" });
      }

      resp.status(200).json(sendItemToCart);

   } catch (error) {
      console.error("Error in addProductToCart:", error.message);
      resp.status(500).json({ error: "Internal Server Error" });
   }
};


const deleteProductFromCart = async (req, resp) => {
   const cartId = req.params._id;
  
   if (!cartId) {
      throw new Error("Cart id Needed in line 37")
   }

   const deleteDataFromCart = await cartModel.findByIdAndDelete(cartId);

   if (!deleteDataFromCart) {
      throw new Error("Some Error Occured While Deleting Data")
   }

   resp.status(200)
      .json(200, deleteDataFromCart, "Data Deleted Successfully")
}

const finditemInCart = async (req,resp) => {

      const userId = req.user
      
      if(!userId)
      {
         return resp.send("User Id is Required");
      }
      
      const cartProducts = await cartModel.aggregate([
         {
         $match:{userId:new ObjectId(userId._id)
         }
      },
      {
         $lookup:{
            from:"users",
            localField:"userId",
            foreignField:"_id",
            as:"UserDetails"
         }
      },
      {
         $lookup:{
            from:"products",
            localField:"productId",
            foreignField:"_id",
            as:"ProductDetails"
         }
      },
      {
         $project:{
            user:{$arrayElemAt:["$UserDetails.username",0]},productId:{$arrayElemAt:["$ProductDetails._id",0]},
            productName:{$arrayElemAt:["$ProductDetails.productName",0]},productPrice:{$arrayElemAt:["$ProductDetails.productPrice",0]},
            productRichDescription:{$arrayElemAt:["$ProductDetails.productRichDesc",0]},
            productShortDescription:{$arrayElemAt:["$ProductDetails.productShortDesc",0]},
            productImages:{$arrayElemAt:["$ProductDetails.productImage",0]}
         }
      }
      ]);

      if(cartProducts.length===0)
      {
        return resp.send("Cart Is Empty");
      }

      resp.status(200)
      .json({cartProducts});
}

module.exports = { addProductToCart, deleteProductFromCart,finditemInCart }