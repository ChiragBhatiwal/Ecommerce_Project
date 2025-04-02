class ProductModel {
  String? productId;
  String? productName;
  num? productPrice;
  String? productShortDesc;
  String? productRichDesc;
  String? sellerId;
  List<dynamic>? productImage;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productShortDesc,
    required this.productRichDesc,
    required this.sellerId,
    required this.productImage,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    productId = json["_id"];
    productName = json["productName"];
    productPrice = json["productPrice"];
    productShortDesc = json["productShortDesc"];
    productRichDesc = json["productRichDesc"];
    sellerId = json["productPublisherId"];
    productImage = json["productImage"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["productId"] = productId;
    data["productName"] = productName;
    data["productPrice"] = productPrice;
    data["productRichDesc"] = productRichDesc;
    data["productShortDesc"] = productShortDesc;
    data["productPublisherId"] = sellerId;
    data["productImage"] = productImage;
    return data;
  }
}
