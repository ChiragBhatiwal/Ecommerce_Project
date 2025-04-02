const mongoose = require("mongoose")
const jwt = require("jsonwebtoken")
const bcrypt = require("bcrypt")

const UserSchema = new mongoose.Schema(
    {
        username: {
            type: String,
            required: true,
            unique: true
        },
        password: {
            type: String,
            required: true
        },
        email: {
            type: String,
            unique: true
        },
        refreshToken: {
            type: String
        },
        Phonenumber: {
            type: String
        },
        LikeProduct: [{
            type: mongoose.Schema.Types.ObjectId,
            ref: "ProductLike"
        }]

    },
    { timestamps: true })

UserSchema.pre("save", async function (next) {
    if (!this.isModified("password")) return next()

    this.password = await bcrypt.hash(this.password, 10)
    return next()
})

UserSchema.methods.isPasswordCorrect = async function (password) {
    return await bcrypt.compare(password, this.password)
}

UserSchema.methods.generateAccessToken = function () {
    return jwt.sign({ _id: this._id, username: this.username }, process.env.SecretKey, { expiresIn: process.env.ACCESSTOKEN_EXPIRY })
}

UserSchema.methods.generateRefreshToken = function () {
    return jwt.sign({ _id: this._id }, process.env.SecretKey, { expiresIn: process.env.REFERSHTOKEN_EXPIRY })

}

module.exports = mongoose.model("User", UserSchema)

