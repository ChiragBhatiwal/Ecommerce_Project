const mongoose = require("mongoose")

const categorySchema = new mongoose.Schema({

    categoryName: {
        type: String,
        enum: ["Baby",
            "Beauty",
            "Books",
            "Clothing & Accesories",
            "Cars & Motorbikes",
            "Electronics",
            "Furniture",
            "Garden & Outdoors",
            "Grocery",
            "Toy",
            "Watches",
            "Health",
            "Jwellery",
            "Industrial",
            "Luggage",
            "Pet Supplies",
            "Music",
            "Video Games",
            "Tools",
            "Sports & Outdoors"],
        required: true
    },
    productId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Product"
    }

}, { timestamps: true })

module.exports = mongoose.model("Category", categorySchema)