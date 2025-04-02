import 'package:ecommerce_flutter/Models/OrderScreenModel/AddressModel.dart';
import 'package:ecommerce_flutter/Models/OrderScreenModel/BillModel.dart';
import 'package:ecommerce_flutter/Models/OrderScreenModel/ProductModel.dart';

class OrderModel {
  late List<AddressModel> addressModel;
  String? username;
  late BillModel billModel;
  late ProductModel productModel;

  OrderModel(
      {required this.username,
      required this.addressModel,
      required this.billModel,
      required this.productModel});

  OrderModel.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    addressModel = (json["findAddress"] as List)
        .map((address) => AddressModel.fromJson(address))
        .toList();
    billModel = BillModel.fromJson(json["bill"]);
    productModel = ProductModel.fromJson(json["product"]);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}
