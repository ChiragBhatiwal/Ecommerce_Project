import 'dart:convert';

import 'package:ecommerce_flutter/Models/UserInformationModel.dart';
import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:http/http.dart' as http;

class UserInfoApi {
  Future<UserInformationModel?> getUserPersonalInfo() async {
    String token = await FlutterStorage().readData();
    final url = Uri.parse("${Constants.api}/user/user-info");
    final response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "${token}"
    });
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return UserInformationModel.fromJson(data);
      }
    } catch (e) {
      return null;
    }
  }
}
