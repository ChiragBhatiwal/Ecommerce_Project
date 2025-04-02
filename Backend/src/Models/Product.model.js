const mongoose = require("mongoose")

const productSchema = new mongoose.Schema({
    productName: {
        type: String,
        required: true
    },
    productPrice: {
        type: Number,
        required: true
    },
    productShortDesc: {
        type: String,
        required: true
    },
    productRichDesc: {
        type: String
    },
    productImage: [{
        type: String
    }],
    productPublisherId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User"
    },
    discountOnProduct: {
        type: Number,
        required: true,
        default: 0,
        min: 0,
        max: 100
    },
    taxOnProduct: {
        type: Number,
        required: true,
    }
    // category: {
    //     type: mongoose.Schema.Types.ObjectId,
    //     ref: "Category"
    // },
    // size: {
    //     type: String,
    //     default: null
    // },
    // review: [{
    //     type: mongoose.Schema.Types.ObjectId,
    //     ref: "Review"
    // }]

}, { timestamps: true })

module.exports = mongoose.model("Product", productSchema)