import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

Future<String?> loadUUID() async {
  return await storage.read(key: 'unique_id');
}

Future<List<Map<String, dynamic>>> fetchData(
    String uuid, String tabType) async {
  try {
    final response =
        await http.get(Uri.parse('http://3.26.221.69:5000/api/transactions'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body) as Map<String, dynamic>;
      final transactions = decodedData.entries
          .map((entry) => entry.value as Map<String, dynamic>)
          .where(
            (transaction) =>
                transaction['user_id'] == uuid &&
                transaction['type'] == tabType,
          )
          .toList();

      return transactions;
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  } catch (e) {
    throw Exception('Lỗi khi tải dữ liệu: $e');
  }
}

List<ExpenseData> processTransactions(List<Map<String, dynamic>> transactions) {
  var categoryData = <String, double>{};
  double totalMoney = 0.0;

  for (final transaction in transactions) {
    var category = transaction['cate_id'].toString();
    var money = (transaction['money'] as num).toDouble();

    totalMoney += money;
    categoryData[category] = (categoryData[category] ?? 0) + money;
  }

  return categoryData.entries.map((entry) {
    double percentage = (entry.value / totalMoney) * 100;
    return ExpenseData(
      percent: '${percentage.toStringAsFixed(1)}%',
      title: entry.key, // Thay thế bằng tên danh mục nếu có
      price: '${NumberFormat("#,###", "vi_VN").format(entry.value)} VND',
    );
  }).toList();
}

class ExpenseData {
  ExpenseData({
    required this.percent,
    required this.title,
    required this.price,
  });

  final String percent;
  final String title;
  final String price;
}
