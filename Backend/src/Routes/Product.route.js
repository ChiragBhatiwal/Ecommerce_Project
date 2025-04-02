const Router = require("express")
const verifyToken = require('../Middlewares/Auth.middleware')
const upload = require("../Middlewares/Multer.middleware")
const { addProduct, updateProduct, deleteProduct, findAllProduct, findProductWithParmeters, findProductWithSearch, findProductWithUser } = require('../Controllers/Product.controller')

const router = Router()

router.route("/addProduct").post(verifyToken, upload.array('images', 10), addProduct)
router.route("/updateProduct/:_id").put(verifyToken, upload.array('images', 10), updateProduct)
router.route("/deleteProduct/:_id").delete(verifyToken, deleteProduct)
router.route("/find").post(findAllProduct);
router.route("/search").post(findProductWithParmeters);
router.route("/item-details/:_id").post(findProductWithSearch);
router.route("/findUserProduct").post(verifyToken, findProductWithUser);
module.exports = router