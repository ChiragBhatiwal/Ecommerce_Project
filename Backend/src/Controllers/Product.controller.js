const productModel = require("../Models/Product.model");
const ApiError = require("../Utils/ApiError.util");
const ApiResponse = require("../Utils/ApiResponse.util");
const {ObjectId} = require("mongodb");

const addProduct = async (req, resp) => {
    const { productName, productPrice, productShortDesc, productRichDesc,taxPrice,discountPercent} = req.body

    if ([productName, productShortDesc, productRichDesc].some((fields) => fields?.trim() === "")) {
        return resp.send("All Fields Are Required");
    }

    const price = parseInt(productPrice);
   
    const taxOnProduct = parseInt(taxPrice);
    const discountOnProduct = parseInt(discountPercent);

    // const productPublisherId = req.user._id
    const productImagePath = req.files    

    // if (!productImage) {
    //     throw new ApiError(400, "Image Required")
    // }

    const userId = req.user;

    if(!userId)
    {
        return resp.send("User id is required");
    }

    const uploadedFiles = productImagePath.map(file => (
         file.path        
      ));

    const product = await productModel.create({
        productName, productPrice:price,productShortDesc, productRichDesc,productImage:uploadedFiles,productPublisherId:userId._id,taxOnProduct,discountOnProduct
    })

    resp.status(200)
        .json(new ApiResponse(200, product, "Product Saved"))
}

const updateProduct = async (req, resp) => {
    const productImagePath = req.files; 
  
    
    let uploadedFiles = [];
    if (productImagePath) {
      uploadedFiles = productImagePath.map(file => file.path);        
    } 

    const { productName, productPrice, productShortDesc, productRichDesc, taxPrice, discountPercent } = req.body;  
   
    if ([productName, productShortDesc, productRichDesc].some((field) => field?.trim() === "")) {
      return resp.send("All Fields Are Required");
    }
  
   
    const { oldImages } = req.body;
    let oldImagesArray = [];
    try {
      oldImagesArray = oldImages ? JSON.parse(oldImages) : [];  
    } catch (error) {
      return resp.status(400).json({ message: "Invalid format for oldImages." });
    }
  
    
    const price = parseInt(productPrice);
    const taxOnProduct = parseInt(taxPrice);
    const discountOnProduct = parseInt(discountPercent);
  
   
    let allImages = [];
    
   
    if (uploadedFiles.length > 0 && oldImagesArray.length > 0) {
      allImages = [...oldImagesArray, ...uploadedFiles]; 
    } else if (uploadedFiles.length > 0) {
      allImages = uploadedFiles; 
    } else if (oldImagesArray.length > 0) {
      allImages = oldImagesArray;  
    }
  
    try {
    
      const productUpdated = await productModel.findByIdAndUpdate(
        req.params._id,
        {
          $set: {
            productName,
            productPrice: price,
            productShortDesc,
            productRichDesc,
            taxOnProduct,
            discountOnProduct,
            productImage: allImages, 
          },
        },
        { new: true } 
      );

      if (!productUpdated) {
        return resp.status(400).send("Product not updated");
      }
  
      // Return the updated product
      return resp.status(200).json(productUpdated);
  
    } catch (error) {
      console.error("Error updating product:", error);
      return resp.status(500).json({ message: "Something went wrong while updating the product." });
    }
  };
  
  

const deleteProduct = async (req, resp) => {
    const product = await productModel.findByIdAndDelete(req.params._id)

    if (!product) {
        return resp.send("product Not Found");
    }

    resp.status(200)
        .json(new ApiResponse(200, product, "Product Delete Successful"))
}

const findAllProduct = async (req, resp) => {
    const product = await productModel.find().limit(5)
   
    if (!product) {
        return resp.send("Product Not Found");
    }

    resp.json(new ApiResponse(200,data={product},"Fetched Products Successfully"));
}

const findProductWithSearch = async (req, resp) => {
    const productId = req.params;
    
    const product = await productModel.findById(
        productId._id
    )    
    
    if (!product) {
        return resp.send("Product not Found");
    }

    resp.status(200)
        .json(new ApiResponse(200, product, "Found product"))
}

const findProductWithParmeters = async (req, resp) => {
    const productData = req.body.name
   
    if (!productData) {
        throw new ApiError(404, "Something went wrong")
    }
    const searchedProduct = await productModel.find({

        "$or": [{ "productName": { $regex: productData } }, { "productShortDesc": { $regex: productData } }]
    })

    if (!searchedProduct) {
        throw new ApiError(404, "Data not found")
    }

    resp.status(200)
        .json(new ApiResponse(201, data={searchedProduct}, "Data Found"))
}

const findProductWithUser = async(req,resp) => {

    const userId = req.user;

    if(!userId)
    {
        return resp.send("User Id is required");
    }

    const findProducts = await productModel.aggregate([
        {
            $lookup:{
               from:"User",
               foreignField:"_id",
               localField:"productPublisherId",
               as:"User-Details"
            }
        },
        {
          $match:{productPublisherId: new ObjectId(userId._id)}
        }
    ]);

    resp.status(200).json({findProducts});
}

module.exports = { addProduct, updateProduct, deleteProduct, findAllProduct, findProductWithSearch, findProductWithParmeters,findProductWithUser }