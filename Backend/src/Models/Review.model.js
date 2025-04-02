const mongoose = require("mongoose")

const reviewSchema = new mongoose.Schema({

    productId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product"
    },
    content: {
        type: String,
        required: true
    }

}, { timestamps: true })

module.exports = mongoose.model("Review", reviewSchema)