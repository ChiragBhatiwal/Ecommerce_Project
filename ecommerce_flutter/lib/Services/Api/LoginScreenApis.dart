import 'dart:convert';

import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:http/http.dart' as http;

class LoginScreenApis {
  static Future<int> loginUser(String username, String password) async {
    const url = '${Constants.api}/user/login-user';
    http.Response response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String refreshToken = data["refreshToken"];
      print(refreshToken);
      FlutterStorage().writeData("refreshToken", refreshToken);
      return 1;
    } else {
      return 0;
    }
  }
}
