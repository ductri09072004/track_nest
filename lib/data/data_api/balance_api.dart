import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

<<<<<<< HEAD
class BalanceService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String?> loadUUID() async {
    return storage.read(key: 'unique_id');
  }

  Future<Map<String, int>> fetchData(String? uuid) async {
    if (uuid == null) return {'expense': 0, 'income': 0};

    try {
      final response =
          await http.get(Uri.parse('http://3.26.221.69:5000/api/transactions'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final transactions = data.entries
            .map((entry) => entry.value as Map<String, dynamic>)
            .toList();

        final userTransactions =
            transactions.where((t) => t['user_id'] == uuid).toList();

        int totalExpense = 0;
        int totalIncome = 0;

        for (final transaction in userTransactions) {
          final int amount = int.tryParse(transaction['money'].toString()) ?? 0;
          if (transaction['type'] == 'expense') {
            totalExpense += amount;
          } else if (transaction['type'] == 'income') {
            totalIncome += amount;
          }
        }

        return {'expense': totalExpense, 'income': totalIncome};
=======
class DataService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String?> loadUUID() async {
    return await storage.read(key: 'unique_id');
  }

  Future<Map<String, int>> fetchBalance(String? uuid) async {
    if (uuid == null) return {'expense': 0, 'income': 0, 'balance': 0};

    try {
      final response = await http.get(Uri.parse(
          'http://3.26.221.69:5000/api/transactions/balence?userId=$uuid'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;

        return {
          'expense': (data['expense'] is int)
              ? data['expense'] as int
              : int.tryParse(data['expense'].toString()) ?? 0,
          'income': (data['income'] is int)
              ? data['income'] as int
              : int.tryParse(data['income'].toString()) ?? 0,
          'balance': (data['balance'] is int)
              ? data['balance'] as int
              : int.tryParse(data['balance'].toString()) ?? 0,
        };
>>>>>>> 9e6a45ba8aa1700c56282e7bcdf968834fd69eda
      } else {
        throw Exception('Không thể tải dữ liệu');
      }
    } catch (e) {
      throw Exception('Lỗi khi tải dữ liệu: $e');
    }
  }
}
