import 'dart:convert';

import 'package:ecommerce_flutter/Models/ItemManagedScreenModel.dart';
import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:http/http.dart' as http;

class ItemManagedScreenApis {
  static Future<List<ItemManagedScreenModel>> fetchAllItems() async {
    List<ItemManagedScreenModel> itemList = [];

    String token = await FlutterStorage().readData();
    const url = "${Constants.api}/product/findUserProduct";

    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json", "Authorization": token});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> result = data["findProducts"];

      for (var product in result) {
        itemList.add(ItemManagedScreenModel.fromJson(product));
      }
    }
    return itemList;
  }

  static Future<int> deleteProduct(String itemId) async {
    final url = Uri.parse("${Constants.api}/product/deleteProduct/$itemId");

    String token = await FlutterStorage().readData();
    http.Response response = await http.delete(url, headers: {
      "Content-Type": "application/json",
      "Authorization": token,
    });

    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}
