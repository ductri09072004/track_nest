import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

Future<String?> loadUUID() async {
  return await storage.read(key: 'unique_id');
}

Future<Map<String, dynamic>?> fetchData(String? uuid) async {
  final response =
      await http.get(Uri.parse('http://3.26.221.69:5000/api/account'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;

    for (var entry in data.entries) {
      var transaction = entry.value as Map<String, dynamic>;
      if (transaction['user_id'] == uuid) {
        return {
          'rootKey': entry.key, // Trả về rootKey
          'transaction': transaction, // Trả về dữ liệu giao dịch
        };
      }
    }

    return null;
  } else {
    throw Exception('Không thể tải dữ liệu');
  }
}
