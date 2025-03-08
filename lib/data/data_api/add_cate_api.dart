import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static Future<void> saveTransaction({
    required BuildContext context,
    required String uuid,
    required String icon,
    required String name,
    required bool isExpense,
  }) async {
    if (uuid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy UUID!')),
      );
      return;
    }

    if (name.isEmpty || icon.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all information!')),
      );
      return;
    }

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

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved transaction successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi: $e')),
      );
    }
  }
}
