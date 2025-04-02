import 'dart:convert';

import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:http/http.dart' as http;

import '../../Models/OrderScreenModel/OrderModel.dart';
import '../../Utils/Constants.dart';

class OrderScreenApis {
  Future<OrderModel?> getDetailsForOrder(int? quantity, String? itemId) async {
    final url = "${Constants.api}/order/order-details/$itemId";

    String token = await FlutterStorage().readData();

    http.Response response = await http.post(Uri.parse(url),
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: jsonEncode({"quantity": quantity}));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return OrderModel.fromJson(data);
    }
  }

  Future<int> placeOrder(String productId, String addressId, int quantity,
      String sellerId, String paymentType, num totalBill) async {
    const url = "${Constants.api}/order/place-order";

    String token = await FlutterStorage().readData();
    http.Response response = await http.post(Uri.parse(url),
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: jsonEncode({
          "addressId": addressId,
          "productId": productId,
          "quantity": quantity,
          "paymentType": paymentType,
          "sellerId": sellerId,
          "totalBill": totalBill
        }));
    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}
