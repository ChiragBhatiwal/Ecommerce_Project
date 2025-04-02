const { registerUser, loginUser, logoutUser,showingUserInformation, updateUserInformation } = require("../Controllers/User.controller")
const router = require("express").Router();
const verifyToken = require("../Middlewares/Auth.middleware");

router.route("/register-user").post(registerUser);
router.route("/login-user").post(loginUser);
router.route("/logout").post(verifyToken, logoutUser);
router.route("/user-info").post(verifyToken,showingUserInformation)
router.route("/update-user").put(verifyToken, updateUserInformation);

module.exports = router