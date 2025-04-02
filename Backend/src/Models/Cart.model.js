const mongoose = require("mongoose")

const cartSchema = new mongoose.Schema({

   userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User"
   },
   productId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Product",
      unique: true
   },


}, { timestamps: true })

module.exports = mongoose.model("Cart", cartSchema)
