import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DataService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String?> loadUUID() async {
    return await storage.read(key: 'unique_id');
  }

  Future<List<Map<String, dynamic>>> fetchDataIcon(String uuid) async {
    try {
      final response =
          await http.get(Uri.parse('http://3.26.221.69:5000/api/categories'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final iconList = data.entries
            .map((entry) => entry.value as Map<String, dynamic>)
            .toList();

        return iconList.where((icon) => icon['user_id'] == uuid).toList();
      } else {
        throw Exception('Không thể tải dữ liệu');
      }
    } catch (e) {
      print('Lỗi: $e');
      return [];
    }
  }
}
