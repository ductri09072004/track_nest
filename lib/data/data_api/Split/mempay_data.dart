import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();

Future<List<Map<String, dynamic>>> fetchDataMem(String? payid) async {
  if (payid == null) {
    throw Exception('payid is not loaded');
  }

  final response =
      await http.get(Uri.parse('http://3.26.221.69:5000/api/mempay'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    final transactions = data.entries
        .map((entry) => entry.value as Map<String, dynamic>)
        .toList();

    return transactions.where((transaction) {
      return transaction['pay_id'] == payid;
    }).toList();
  } else {
    throw Exception('Không thể tải dữ liệu');
  }
}
