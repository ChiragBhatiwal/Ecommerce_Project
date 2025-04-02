import 'dart:convert';

import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:http/http.dart' as http;

class PanelApis {
  Future<Map<String, dynamic>> getPanelDetails() async {
    String token = await FlutterStorage().readData();
    final url = Uri.parse("${Constants.api}/order/getPannelStatus");
    http.Response response = await http.post(url, headers: {
      "Authorization": token,
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
