const mongoose = require('mongoose')

const DATABASE_CONNECTION = async() => {
    try {
       await mongoose.connect("mongodb://localhost:27017/ecomm") 
    } catch (error) {
       console.log("database not found/or connected") 
    }
}

module.exports = DATABASE_CONNECTION