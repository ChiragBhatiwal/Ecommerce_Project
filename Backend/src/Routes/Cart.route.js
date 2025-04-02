const { addProductToCart, deleteProductFromCart, finditemInCart } = require("../Controllers/Cart.controller")
const Router = require("express")
const verifyToken = require("../Middlewares/Auth.middleware")
const router = Router()

router.route("/addToCart/:_id").post(verifyToken, addProductToCart)
router.route("/deleteCartItem/:_id").delete(verifyToken, deleteProductFromCart)
router.route("/find").post(verifyToken, finditemInCart)
module.exports = router
