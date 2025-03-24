import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService {

  static Future<bool> saveCategory({
    required String uuid,
    required String icon,
    required String name,
    required bool isExpense,
    http.Client? client,
  }) async {

    client ??= http.Client();

    if (uuid.isEmpty) {throw Exception('UUID không được rỗng');}
    if (icon.isEmpty) {throw Exception('Icon không được rỗng');}
    if (name.isEmpty) {throw Exception('Name không được rỗng');}

      final url = Uri.parse('http://3.26.221.69:5000/api/categories');
      final categoryData = {
        'icon': icon,
        'name': name,
        'type': isExpense ? 'expense' : 'income',
        'user_id': uuid,
      };

    try {
      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(categoryData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true; // Thành công
      } else {
        return false; // Lỗi server
      }
    } catch (e) {
      return false; // Lỗi kết nối
    }
  }

  static Future<bool> deleteCategory({
    required String categoryId,
    http.Client? client,
  }) async {
    client ??= http.Client();

    if (categoryId.isEmpty) {
      throw Exception('Category ID không được rỗng');
    }

    try {
      final response = await client.delete(
        Uri.parse('http://3.26.221.69:5000/api/categories/$categoryId'),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true; // Xóa thành công
      } else {
        return false; // Lỗi từ server
      }
    } catch (e) {
      return false; // Lỗi kết nối
    }
  }

  static Future<bool> updateCategory({
    required String categoryId,
    required String icon,
    required String name,
    required bool isExpense,
    http.Client? client,
  }) async {
    client ??= http.Client();

    if (categoryId.isEmpty) throw Exception('Category ID không được rỗng');
    if (icon.isEmpty) throw Exception('Icon không được rỗng');
    if (name.isEmpty) throw Exception('Name không được rỗng');

    final url = Uri.parse('http://3.26.221.69:5000/api/categories/$categoryId');
    final updateData = {
      'icon': icon,
      'name': name,
      'type': isExpense ? 'expense' : 'income',
    };

    try {
      final response = await client.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updateData),
      );

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      return false;
    }
  }




}
