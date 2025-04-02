const jwt = require('jsonwebtoken')
const userModel = require('../Models/User.model')

const verifyToken = async (req, _, next) => {
    try {
        const token = req.cookies?.accessToken || req.header("Authorization")?.replace("Bearer ","");        
      
        if (!token) {
           return console.log("Token Required");
        }
         
        const decodedToken = jwt.verify(token,process.env.SecretKey)
    
        const userId = await userModel.findById(decodedToken?._id).select("-password -refreshToken")
    
        if (!userId) {
            return console.log("User Not Found with this token");
           
        }
    
        req.user = userId;
        next();
    } catch (error) {
      console.log(error);
    }
}


module.exports = verifyToken