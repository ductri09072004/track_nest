import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static String generateGtransId() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(10, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  static Future<void> saveAllTransactions({
    required BuildContext context,
    required List<int> splitAmounts,
    required List<String> options,
    required List<bool> toggleStates,
    required Function(String) onPayidGenerated,
    required String selectedOption, // Người trả chính phải được truyền vào
  }) async {
    try {
      String payid = generateGtransId();
      onPayidGenerated(payid);
      List<Future<void>> apiCalls = [];

      for (int i = 0; i < options.length; i++) {
        bool isPayer = options[i] == selectedOption;

        if (toggleStates[i] || isPayer) {
          // Lưu cả người trả chính
          int money = splitAmounts[i];
          String name = options[i];

          if (money <= 0 || name.isEmpty || payid.isEmpty) {
            throw Exception(
                'Thiếu dữ liệu: money=$money, name=$name, payid=$payid',);
          }

          apiCalls.add(_saveTransaction(context, money, name, payid, isPayer));
        }
      }

      await Future.wait(apiCalls);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lưu dữ liệu thành công!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi lưu dữ liệu: $e')),
      );
    }
  }

  static Future<void> _saveTransaction(
    BuildContext context,
    int money,
    String name,
    String payid,
    bool isPayer, // Thêm tham số isPayer
  ) async {
    try {
      final url = Uri.parse('http://3.26.221.69:5000/api/mempay');
      final transactionData = {
        'money_pay': money,
        'name_pay': name,
        'pay_id': payid,
        'pay_main': isPayer
            ? 'true'
            : 'false', // Nếu là người trả chính thì true, ngược lại false
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(transactionData),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Save failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Lỗi API: $e');
    }
  }
}
