import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static Future<void> saveTransaction({
    required BuildContext context,
    required String uuid,
    required String namegroup,
    required String namemen,
  }) async {
    if (uuid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy UUID!')),
      );
      return;
    }

    if (namegroup.isEmpty || namemen.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all information!')),
      );
      return;
    }

    try {
      final url = Uri.parse('http://3.26.221.69:5000/api/groupmem');

      final transactionData = {
        'name_group': namegroup,
        'name_mem': namemen,
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
