const mongoose = require("mongoose")

const orderSchema = new mongoose.Schema({

    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User"
    },
    productId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product"
    },
    addressId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Address"
    },
    totalBill: {
        type: Number,
        required: true,
    },
    quantity: {
        type: Number,
        required: true,
        default: 1,
        max: 16
    },
    paymentType: {
        type: String,
        enum: ["COD", "CARD", "UPI", "PAYPAL"],
        required: true
    },
    status: {
        type: String,
        required: true,
        default: "Pending",
        enum: ['Pending', 'Confirmed', 'Packed', 'Shipped', 'Delivered', 'Cancelled', 'Refunded', 'Rejected']
    },
    sellerId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true
    }

}, { timestamps: true })

module.exports = mongoose.model("Order", orderSchema)