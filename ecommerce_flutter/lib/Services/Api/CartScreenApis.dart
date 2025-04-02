import 'dart:convert';

import 'package:ecommerce_flutter/Models/CartScreenModels.dart';
import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:http/http.dart' as http;

class CartScreenApis {
  static Future<String?> _getToken() async {
    return await FlutterStorage().readData();
  }

  static Future<int> addProductInCart(String id) async {
    String? token = await _getToken();
    var url = '${Constants.api}/cart/addToCart/$id';
    http.Response response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json", "Authorization": token!});

    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }

  static Future<List<CartScreenModel>> getCartProducts() async {
    List<CartScreenModel> productList = [];

    String? token = await _getToken();
    const url = '${Constants.api}/cart/find';

    http.Response response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json", "Authorization": token!});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic>? result = data["cartProducts"];

      for (var i = 0; i < result!.length; i++) {
        CartScreenModel cartScreenModel = CartScreenModel.fromJson(result[i]);
        productList.add(cartScreenModel);
      }
    }

    return productList;
  }

  static Future<int> deleteProductFromCart(String itemId) async {
    final url = Uri.parse("${Constants.api}/cart//deleteCartItem/$itemId");
    String token = await FlutterStorage().readData();
    http.Response response = await http.delete(url,
        headers: {"Content-Type": "application/json", "Authorization": token});

    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}
