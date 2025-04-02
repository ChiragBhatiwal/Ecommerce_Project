const express = require("express")
const userRouter = require('./Routes/User.route')
const productRouter = require('./Routes/Product.route')
const addressRouter = require("./Routes/Address.route")
const cartRouter = require('./Routes/Cart.route')
const orderRouter = require("./Routes/Order.Route");
const app = express();
const cookieparser = require('cookie-parser')
const cors = require("cors")
const helmet = require("helmet")


app.use(helmet())
app.use(express.json())
app.use(cookieparser())
app.use(express.urlencoded({ extended: true }))
app.use(cors())

app.use("/user", userRouter);
app.use("/product", productRouter);
app.use("/cart", cartRouter);
app.use("/address", addressRouter);
app.use("/order", orderRouter);
module.exports = app
