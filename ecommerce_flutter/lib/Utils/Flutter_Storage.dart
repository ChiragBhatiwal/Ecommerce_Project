import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  writeData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  writeIdData(String id) async {
    await storage.write(key: "id", value: id);
  }

  readData() async {
    String? value = await storage.read(key: "refreshToken");
    return value;
  }

  readIdData() async {
    String? id = await storage.read(key: "id");
    return id;
  }

  clearData() async {
    await storage.deleteAll();
  }
}
