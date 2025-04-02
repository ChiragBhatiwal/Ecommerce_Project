import 'dart:convert';

import 'package:ecommerce_flutter/Models/OrderShowingScreen_ManageAccount.dart';
import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:http/http.dart' as http;

class OrderShowingApi {
  // Fetch Buy Again Orders
  Future<List<OrderShowingModel>> fetchBuyAgainOrders() async {
    List<OrderShowingModel> orderList = [];
    String token = await FlutterStorage().readData();

    try {
      final response = await http.post(
        Uri.parse("${Constants.api}/order/buy-again"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        var decodedBody = jsonDecode(response.body);

        if (decodedBody is List) return [];

        List<dynamic> list = decodedBody["result"] ?? [];
        orderList = list.map((e) => OrderShowingModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load buy again orders: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching buy again orders: $e");
    }
    return orderList;
  }

  // Fetch Current Orders
  Future<List<OrderShowingModel>> fetchCurrentOrders() async {
    List<OrderShowingModel> orderList = [];
    String token = await FlutterStorage().readData();

    try {
      final response = await http.post(
        Uri.parse("${Constants.api}/order/on-going-orders"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        var decodedBody = jsonDecode(response.body);

        if (decodedBody is List) return [];

        List<dynamic> list = decodedBody["result"] ?? [];
        orderList = list.map((e) => OrderShowingModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load current orders: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error fetching current orders: $e");
    }
    return orderList;
  }
}
