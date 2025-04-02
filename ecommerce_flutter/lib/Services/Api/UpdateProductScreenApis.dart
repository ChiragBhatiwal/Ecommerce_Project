import 'dart:convert';

import 'package:ecommerce_flutter/Utils/Constants.dart';
import 'package:ecommerce_flutter/Utils/Flutter_Storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class UpdateProductScreenApis {
  static Future<int> UpdateProduct(
      String itemId,
      List<XFile> images,
      List<dynamic> oldImages,
      String productName,
      String productPrice,
      String productShortDesc,
      String productRichDesc,
      String discountPercent,
      String taxPrice) async {
    print(images);
    final String token = await FlutterStorage().readData();
    var url = "${Constants.api}/product/updateProduct/${itemId}";

    var request = http.MultipartRequest("PUT", Uri.parse(url));
    request.headers["Authorization"] = 'Bearer $token';

    for (var image in images) {
      var mimeType = lookupMimeType(image.path) ?? "image/jpg";
      var file = await http.MultipartFile.fromPath("images", image.path,
          contentType: MediaType.parse(mimeType));

      request.files.add(file);
    }

    request.fields["oldImages"] = jsonEncode(oldImages);
    request.fields["productName"] = productName;
    request.fields["productPrice"] = productPrice;
    request.fields["productShortDesc"] = productShortDesc;
    request.fields["productRichDesc"] = productRichDesc;
    request.fields["discountPercent"] = discountPercent;
    request.fields["taxPrice"] = taxPrice;

    var response = await request.send();

    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}
