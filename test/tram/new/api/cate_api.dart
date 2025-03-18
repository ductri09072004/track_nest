import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService {
  static Future<bool> saveCategory({
    required String? uuid,
    required String? icon,
    required String? name,
    required bool isExpense,
    http.Client? client,
  }) async {
    client ??= http.Client();
    try {
      if (uuid == null || uuid.isEmpty) {
        throw Exception('UUID không được rỗng');}
      if (icon == null || icon.isEmpty) {
        throw Exception('Icon không được rỗng');}
      if (name == null || name.isEmpty) {
        throw Exception('Name không được rỗng');}
        
      final url = Uri.parse('http://3.26.221.69:5000/api/categories');
      final categoryData = {
        'icon': icon,
        'name': name,
        'type': isExpense ? 'expense' : 'income',
        'user_id': uuid,
      };

      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(categoryData),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      return false; // Lỗi kết nối hoặc server
    }
  }
}
