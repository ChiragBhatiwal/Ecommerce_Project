class SearchScreenModel {
  String? sId;
  String? productName;
  num? productPrice;
  String? productShortDesc;
  String? productRichDesc;
  List<dynamic>? productImage;

  SearchScreenModel({
    this.sId,
    this.productName,
    this.productPrice,
    this.productShortDesc,
    this.productRichDesc,
    this.productImage,
  });

  SearchScreenModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productShortDesc = json['productShortDesc'];
    productRichDesc = json['productRichDesc'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['productShortDesc'] = this.productShortDesc;
    data['productRichDesc'] = this.productRichDesc;
    data['productImage'] = this.productImage;
    return data;
  }
}
