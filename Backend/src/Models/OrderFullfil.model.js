const mongoose = require("mongoose")

const orderFullfill = new mongoose.Schema({

   orderId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Order"
   },
   deliveryStatus: {
      type: String,
      enum: ['Pending', 'Delivered', "Shipped", "Return", "Out For Delivery"],
      required: true
   }

}, { timestamps: true })

module.exports = mongoose.model("OrderFullfill", orderFullfill)