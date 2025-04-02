import 'dart:convert';

import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:http/http.dart' as http;

import '../../Models/ProductDetailScreenModel.dart';

class ProductDetailScreenApi {
  static Future<ProductDetailScreenModel> itemDetails(String? id) async {
    final url = '${Constants.api}/product/item-details/$id';
    http.Response response = await http
        .post(Uri.parse(url), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      return ProductDetailScreenModel.fromJson(responseData["data"]);
    } else {
      return ProductDetailScreenModel();
    }
  }
}
