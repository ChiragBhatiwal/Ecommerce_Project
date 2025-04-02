import 'dart:convert';

import 'package:ecommerce_flutter/Models/SearchScreenModels.dart';
import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:http/http.dart' as http;

class SearchScreenApis {
  Future<List<SearchScreenModel>> getProductBySearchParameter(
      {required value}) async {
    List<SearchScreenModel> productList = [];
    const url = "${Constants.api}/product/search";
    final response = await http.post(Uri.parse(url),
        body: jsonEncode({"name": value}),
        headers: {"content-type": "application/json"});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> result = data["data"]["searchedProduct"];

      for (int i = 0; i < result.length; i++) {
        SearchScreenModel product = SearchScreenModel.fromJson(result[i]);
        productList.add(product);
      }
    }
    return productList;
  }
}
