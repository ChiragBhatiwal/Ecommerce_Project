import 'dart:convert';

import 'package:ecommerce_flutter/Models/AddressScreenModel.dart';
import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:http/http.dart' as http;

class AddressScreenApis {
  static Future<int> addAddress(
      String title,
      String fullname,
      String mobile,
      String city,
      String state,
      String pincode,
      String country,
      String address) async {
    String token = await FlutterStorage().readData();

    final url = "${Constants.api}/address/register";
    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "title": title,
          "fullName": fullname,
          "mobileNumber": mobile,
          "address": address,
          "city": city,
          "pincode": pincode,
          "country": country,
          "state": state
        }),
        headers: {"Authorization": token, "Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<List<AddressScreenModel>> getUserAddresses() async {
    List<AddressScreenModel> address = [];
    String token = await FlutterStorage().readData();

    const url = "${Constants.api}/address/find";
    http.Response response = await http.post(Uri.parse(url),
        headers: {"Authorization": token, "Content-Type": "application/json"});

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> products = data["findUserAddresses"];

      for (var item in products) {
        address.add(AddressScreenModel.fromJson(item));
      }
    }
    return address;
  }

  Future<int?> findAddress() async {
    String token = await FlutterStorage().readData();

    const url = "${Constants.api}/address/find";

    http.Response response =
        await http.post(Uri.parse(url), headers: {"Authorization": token});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body); // Parse the JSON response
      var addresses = data['findUserAddresses'] ?? [];

      if (addresses.isEmpty) {
        return 0; // No addresses found
      } else {
        return 1;
      } // Addresses found
    } else {
      return 0; // Error in response
    }
  }
}
