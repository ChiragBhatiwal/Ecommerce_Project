const addressModel = require("../Models/Address.model")
const ApiError = require("../Utils/ApiError.util")
const ApiResponse = require("../Utils/ApiResponse.util");
const {ObjectId} = require("mongodb");

const registerAddress = async (req, resp) => {
    try {
      const userId = req.user; 
  
      if (!userId) {
        return resp.status(400).json({ error: "User ID is required" });
      }
  
      const { title, fullName, mobileNumber, address, city, state, pincode, country } = req.body;
      
      if (
        [title, fullName, mobileNumber, address, city, state, pincode, country].some(
          (field) => !field || field.trim() === ""
        )
      ) {
        return resp.status(400).json({ error: "All fields are required" });
      }
  
      const saveAddress = await addressModel.create({
        title,
        fullName,
        mobileNumber,
        address,
        city,
        state,
        pincode,
        country,
        user: userId, 
      });

      return resp.status(200).json({ message: "Address saved successfully", address: saveAddress });
    } catch (error) {
      
      return resp.status(500).json({ error: "Something went wrong while saving the address" });
    }
  };
  

const getUserAddress = async (req,resp) => {
    
    const userId = req.user;

    if(!userId)
    {
        return resp.send("User id is required");
    }

    const findUserAddresses = await addressModel.aggregate([
        {
            $match:{user:new ObjectId(userId._id)}
        },
        {
          $lookup:{
            from:"users",
            localField:"user",
            foreignField:"_id",
            as:"UserDetails"
          }   
        },
        {
            $project:{
                title:1,mobileNumber:1,
                username:{$arrayElemAt:["$UserDetails.username",0]},city:1,address:1,state:1,pincode:1,country:1
            }
        }
    ]);

    if(!findUserAddresses)
    {
        return resp.send("Can't find User Address")
    }

    return resp.status(200).json({findUserAddresses});
}

module.exports = {registerAddress,getUserAddress};