import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class DataService {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String?> loadUUID() async {
    return await storage.read(key: 'unique_id');
  }

  Future<List<Map<String, dynamic>>> fetchData(
      String? uuid, String tabType) async {
    if (uuid == null) return [];

    try {
      final response =
          await http.get(Uri.parse('http://3.26.221.69:5000/api/transactions'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final allTransactions = data.entries
            .map((entry) => entry.value as Map<String, dynamic>)
            .toList();

        return allTransactions
            .where((transaction) =>
                transaction['user_id'] == uuid &&
                transaction['type'] == tabType)
            .toList();
      } else {
        throw Exception('Không thể tải dữ liệu');
      }
    } catch (e) {
      throw Exception('Lỗi khi tải dữ liệu: $e');
    }
  }
}
