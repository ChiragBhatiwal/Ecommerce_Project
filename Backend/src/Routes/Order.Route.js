const router = require("express").Router();
const verifyToken = require("../Middlewares/Auth.middleware");
const { placingOrder, getProductDetailsForShowingInPreOrderProcessing, priicingOnTheBasesOfQuantityUpdate, getOrderStatus, getBuyAgainOrders, getCurrentOrderedProductsList } = require("../Controllers/Order.controller");

router.route("/place-order").post(verifyToken, placingOrder);
router.route("/get-orders").post(verifyToken, getProductDetailsForShowingInPreOrderProcessing);
router.route("/order-details/:_id").post(verifyToken, priicingOnTheBasesOfQuantityUpdate);
router.route("/getPannelStatus").post(verifyToken, getOrderStatus);
router.route("/buy-again").post(verifyToken, getBuyAgainOrders);
router.route("/on-going-orders").post(verifyToken, getCurrentOrderedProductsList);

module.exports = router;