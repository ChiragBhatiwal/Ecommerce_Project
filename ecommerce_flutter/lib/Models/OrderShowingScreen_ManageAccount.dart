class OrderShowingModel {
  String id;
  int totalBill;
  int quantity;
  String paymentType;
  String status;
  DateTime createdAt;
  String productId;
  String productName;
  int productPrice;
  List<String> productImage;

  OrderShowingModel({
    required this.id,
    required this.totalBill,
    required this.quantity,
    required this.paymentType,
    required this.status,
    required this.createdAt,
    required this.productId,
    required this.productPrice,
    required this.productName,
    required this.productImage,
  });

  // JSON to Object
  factory OrderShowingModel.fromJson(Map<String, dynamic> json) {
    return OrderShowingModel(
      id: json["_id"],
      totalBill: json["totalBill"],
      quantity: json["quantity"],
      paymentType: json["paymentType"],
      status: json["status"],
      createdAt: DateTime.parse(json["createdAt"]),
      productId: json["productId"],
      productPrice: json["productPrice"],
      productName: json["productName"],
      productImage: List<String>.from(json["productImage"] ?? []),
    );
  }

  // Object to JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "totalBill": totalBill,
      "quantity": quantity,
      "paymentType": paymentType,
      "status": status,
      "createdAt": createdAt.toIso8601String(),
      "productId": productId,
      "productName": productName,
      "productPrice": productPrice,
      "productImage": productImage,
    };
  }
}
