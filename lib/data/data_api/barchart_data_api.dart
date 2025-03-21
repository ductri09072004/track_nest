import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DataService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String?> loadUUID() async {
    return await storage.read(key: 'unique_id');
  }

  Future<List<Map<String, dynamic>>> fetchData(
      String? uuid, String tabType) async {
    if (uuid == null) return [];

    try {
      final uri =
          Uri.parse('http://3.26.221.69:5000/api/transactions/filteridtype')
              .replace(queryParameters: {'user_id': uuid, 'tabType': tabType});

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        //final List<dynamic> data = json.decode(response.body);
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Không thể tải dữ liệu');
      }
    } catch (e) {
      throw Exception('Lỗi khi tải dữ liệu: $e');
    }
  }
}
