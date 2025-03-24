import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static Future<void> saveCategory({
    required BuildContext context,
    required String uuid,
    required String icon,
    required String name,
    required bool isExpense,
  }) async {
    try {
      final url = Uri.parse('http://3.26.221.69:5000/api/categories');
      final transactionData = {
        'icon': icon,
        'name': name,
        'type': isExpense ? 'expense' : 'income',
        'user_id': uuid,
      };
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(transactionData),
      );

      // Xử lý phản hồi từ Backend
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lưu giao dịch thành công!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['error'].toString())),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi kết nối: $e')),
      );
    }
  }
}
