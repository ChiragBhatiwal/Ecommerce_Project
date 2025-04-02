import 'dart:convert';

import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:http/http.dart' as http;

class SignupScreenApis {
  static Future<int> signingupUser(
      String username, String email, String password) async {
    const url = '${Constants.api}/user/register-user';
    http.Response response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {"username": username, "email": email, "password": password}));

    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}
