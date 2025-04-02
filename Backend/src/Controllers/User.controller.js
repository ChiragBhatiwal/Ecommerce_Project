const cartModel = require("../Models/Cart.model")
const userModel = require('../Models/User.model')
const ApiError = require('../Utils/ApiError.util')
const ApiResponse = require('../Utils/ApiResponse.util')
const bcrypt = require("bcrypt");

const generateRefreshandAccessToken = async (userId) => {
    try {
        const user = await userModel.findById(userId)
        const refreshToken = await user.generateRefreshToken()
        const accessToken = await user.generateAccessToken()

        user.refreshToken = refreshToken
        user.save({ validateBeforeSave: false })

        return { refreshToken, accessToken }
    } catch (error) {
        throw new ApiError(400, "can't generate refersh Token")
    }

}

const registerUser = async (req, resp) => {
    const { username, password, email } = req.body

    if ([username, password, email].some((fields) => fields?.trim() === "")) {
        throw new ApiError(400, "required all fields")
    }

    const existedUser = await userModel.findOne({
        $or: [{ username }, { email }]
    })

    if (existedUser) {
        throw new ApiError(400, 'User already Exists')
    }

    const user = await userModel.create({
        username,
        password,
        email
    })

    const findUser = await userModel.findById(user._id).select("-password -refreshToken")

    if (!findUser) {
        throw new ApiError(400, "User Not found")
    }

    const cartCreated = await cartModel.create({ userId: user._id })

    if (!cartCreated) {
        return resp.status(404).json({ message: "Cart isn't Created" });
    }

    resp.status(200)
        .json(new ApiResponse(201, data = { findUser, cartCreated }, "User created Successfully"))
}

const loginUser = async (req, resp) => {
    const { username, password } = req.body

    if ([username, password].some((fields) => fields?.trim() === "")) {
        throw new ApiError(400, "All fields required")
    }

    const userExists = await userModel.findOne({ username })

    if (!userExists) {
        throw new ApiError(400, "User not found")
    }

    const PasswordCorrect = await userExists.isPasswordCorrect(password)

    if (!PasswordCorrect) {
        throw new ApiError(400, "Password Not Correct")
    }

    const { refreshToken, accessToken } = await generateRefreshandAccessToken(userExists._id)

    const user = await userModel.findById(userExists._id).select('-password -refreshToken')

    const Options = {
        httpOnly: true,
        secure: true
    }

    resp.status(200)
        // .cookie('AccessToken', accessToken, Options)
        // .cookie('RefreshToken', refreshToken, Options)
        .json({ user, refreshToken, accessToken });
}

const logoutUser = async (req, resp) => {

    const data = await userModel.findById(
        req.user?._id,
        {
            $unset: {
                refreshToken: 1
            }

        },
        {
            new: true
        }
    )

    const Options = {
        httOnly: true,
        secure: true
    }

    resp.status(201)
        .clearCokkie("AccessToken", Options)
        .clearCookie("RefreshToken", Options)
        .json(new ApiResponse(200, data, "User Logout Successfully"))

}

const showingUserInformation = async (req, resp) => {
    console.log("Re Run");
    const userId = req.user;

    if (!userId) {
        return resp.status(404).json({ message: "User Not Found" });
    }

    const userInformation = await userModel.findById(userId, { password: 0 ,refreshToken:0,__v:0,updatedAt:0,LikeProduct:0});

    if (!userInformation) {
        return resp.status(404).json({ message: "No User Found" });
    }

    return resp.status(200).json(userInformation);
}

const updateUserInformation = async (req, resp) => {
    try {
        const userId = req.user;
        const updateData = req.body

        if (updateData.password) {
            updateData.password = await bcrypt.hash(updateData.password, 10)
        }

        const updatedUser = await userModel.findByIdAndUpdate(
            userId._id,
            { $set: updateData },
            { new: true, runValidators: true }
        )

        if (!updatedUser) {
            return resp.status(404).json({ message: "User not found" })
        }

        resp.status(200).json({ message: "User updated successfully"})
    } catch (error) {
        resp.status(500).json({ message: "Something went wrong", error: error.message })
    }
}

module.exports = { registerUser, loginUser, logoutUser, updateUserInformation, showingUserInformation }