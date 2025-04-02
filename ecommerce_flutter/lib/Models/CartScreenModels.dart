class CartScreenModel {
  String? sId;
  String? productName;
  String? productId;
  num? productPrice;
  String? productShortDesc;
  String? productRichDesc;
  List<dynamic>? productImage;

  CartScreenModel({
    this.sId,
    this.productName,
    this.productId,
    this.productPrice,
    this.productShortDesc,
    this.productRichDesc,
    this.productImage,
  });

  CartScreenModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productId = json["productId"];
    productShortDesc = json['productShortDescription'];
    productRichDesc = json['productRichDescription'];
    productImage = json['productImages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['productShortDesc'] = this.productShortDesc;
    data['productRichDesc'] = this.productRichDesc;
    data['productImages'] = this.productImage;
    return data;
  }
}
