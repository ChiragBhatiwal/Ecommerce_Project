const { registerAddress, getUserAddress } = require("../Controllers/Address.controller")
const Router = require("express")
const verifyJWT = require("../Middlewares/Auth.middleware")
const router = Router()

router.route("/register").post(verifyJWT, registerAddress);
router.route("/find").post(verifyJWT, getUserAddress);

module.exports = router