import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

Future<String?> loadUUID() async {
  return await storage.read(key: 'unique_id');
}

Future<List<Map<String, dynamic>>> fetchData(String? uuid) async {
  if (uuid == null) {
    throw Exception('UUID is not loaded');
  }

  final response =
      await http.get(Uri.parse('http://3.26.221.69:5000/api/groupmem'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    final transactions = data.entries
        .map((entry) => entry.value as Map<String, dynamic>)
        .toList();

    return transactions.where((transaction) {
      return transaction['user_id'] == uuid;
    }).toList();
  } else {
    throw Exception('Không thể tải dữ liệu');
  }
}
