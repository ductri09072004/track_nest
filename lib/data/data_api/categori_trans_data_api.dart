import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CategoryService {
  final storage = const FlutterSecureStorage();

  Future<String?> loadUUID() async {
    return await storage.read(key: 'unique_id');
  }

  Future<List<Map<String, dynamic>>> fetchCustomerData({
    required String? uuid,
    required bool isExpense,
  }) async {
    if (uuid == null) {
      throw Exception('Không tìm thấy UUID!');
    }

    try {
      final Uri url = Uri.parse(
          'http://3.26.221.69:5000/api/categories/filter?user_id=$uuid&type=${isExpense ? 'expense' : 'income'}');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedBody = json.decode(response.body);

        if (decodedBody is List) {
          return decodedBody.cast<Map<String, dynamic>>();
        } else {
          throw Exception('Dữ liệu API không hợp lệ: $decodedBody');
        }
      } else {
        throw Exception('Lỗi kết nối API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi tải dữ liệu: $e');
    }
  }
}
