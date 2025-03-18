import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  /// Tạo gtransid ngẫu nhiên gồm 10 ký tự chữ và số
  static String generateGtransId() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(10, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  static Future<void> saveTransaction({
    required BuildContext context,
    required String uuid,
    required String icon,
    required DateTime date,
    required String money,
    required String note,
    required String payid,
  }) async {
    if (uuid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy UUID!')),
      );
      return;
    }

    if (icon.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all information!')),
      );
      return;
    }

    try {
      final url = Uri.parse('http://3.26.221.69:5000/api/grouptrans');

      final String gtransid = generateGtransId(); // Gọi hàm tạo gtransid

      final transactionData = {
        'cate_id': icon,
        'date': '${date.day}/${date.month}/${date.year}',
        'gtrans_id': gtransid,
        'money': int.tryParse(money.replaceAll('.', '')) ?? 0,
        'note': note,
        'pay_id': payid,
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
