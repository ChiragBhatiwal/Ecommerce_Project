class BillModel {
  num? productPrice;
  num? discountedPrice;
  num? priceWithTax;
  num? quantity;
  num? totalBill;
  num? discountPercentage;
  num? chargesAndTax;

  BillModel(
      {this.productPrice,
      this.discountedPrice,
      this.priceWithTax,
      this.quantity,
      this.totalBill,
      this.discountPercentage,
      this.chargesAndTax});

  BillModel.fromJson(Map<String, dynamic> json) {
    productPrice = json["productPrice"];
    discountedPrice = json["discountedPrice"];
    priceWithTax = json["priceWithTax"];
    quantity = json["quantity"];
    totalBill = json["totalBill"];
    discountPercentage = json["discountPercentage"];
    chargesAndTax = json["chargesAndTax"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["productPrice"] = this.productPrice;
    data["discountedPrice"] = this.discountedPrice;
    data["priceWithTax"] = this.priceWithTax;
    data["quantity"] = this.quantity;
    data["totalBill"] = this.totalBill;
    data["discountPercentage"] = this.discountPercentage;
    data["chargesAndTax"] = this.chargesAndTax;
    return data;
  }
}
