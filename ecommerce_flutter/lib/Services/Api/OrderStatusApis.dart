import 'dart:convert';

import 'package:ecommerce_flutter/Models/OrderStatus_SellerAccountModel.dart';
import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:http/http.dart' as http;

class ManageOrderStatusApis {
  Future<List<OrderStatusModel>> getOrders(dynamic key) async {
    String token = await FlutterStorage().readData();
    const url = "${Constants.api}/order/get-orders";
    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode({"key": key}),
        headers: {"Authorization": token, "Content-Type": "application/json"});

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((order) => OrderStatusModel.fromJson(order)).toList();
    } else {
      return [];
    }
  }

  void ordersManage() {}
}
