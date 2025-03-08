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
      final response =
          await http.get(Uri.parse('http://3.26.221.69:5000/api/categories'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        final filteredCategories = data.entries
            .where(
              (entry) =>
                  entry.value['user_id'] == uuid &&
                  entry.value['type'] == (isExpense ? 'expense' : 'income'),
            )
            .map((entry) => entry.value as Map<String, dynamic>)
            .toList();

        return filteredCategories;
      } else {
        throw Exception('Lỗi kết nối API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi tải dữ liệu: $e');
    }
  }
}
