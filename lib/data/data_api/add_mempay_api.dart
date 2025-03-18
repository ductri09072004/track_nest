import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static Future<void> saveTransaction({
    required BuildContext context,
    required int money,
    required String name,
    required String payid,
    required String status,
  }) async {
    try {
      final url = Uri.parse('http://3.26.221.69:5000/api/mempay');

      final transactionData = {
        'money_pay': money,
        'name_pay': name,
        'pay_id': payid,
        'pay_main': status,
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
