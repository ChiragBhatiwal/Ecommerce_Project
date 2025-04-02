class OrderStatusModel {
  String? orderId;
  num? totalBill;
  int? quantity;
  String? paymentType;
  String? status;
  String? productId;
  String? userId;
  String? productName;
  num? productPrice;
  String? username;
  String? userAddress;
  String? userCity;
  String? userState;
  String? userPincode;

  OrderStatusModel(
      {this.orderId,
      this.totalBill,
      this.quantity,
      this.paymentType,
      this.status,
      this.productId,
      this.userId,
      this.productName,
      this.productPrice,
      this.username,
      this.userAddress,
      this.userCity,
      this.userState,
      this.userPincode});

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    orderId = json['_id'];
    totalBill = json['totalBill'];
    quantity = json['quantity'];
    paymentType = json['paymentType'];
    status = json['status'];
    productId = json['productId'];
    userId = json['userId'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    username = json['username'];
    userAddress = json['userAddress'];
    userCity = json['userCity'];
    userState = json['userState'];
    userPincode = json['userPincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.orderId;
    data['totalBill'] = this.totalBill;
    data['quantity'] = this.quantity;
    data['paymentType'] = this.paymentType;
    data['status'] = this.status;
    data['productId'] = this.productId;
    data['userId'] = this.userId;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['username'] = this.username;
    data['userAddress'] = this.userAddress;
    data['userCity'] = this.userCity;
    data['userState'] = this.userState;
    data['userPincode'] = this.userPincode;
    return data;
  }
}
