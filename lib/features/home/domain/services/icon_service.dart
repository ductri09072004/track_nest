import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testverygood/features/home/domain/models/icon_model.dart';

class IconService {
  Future<String?> loadUUID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uuid'); // Lấy UUID từ bộ nhớ
  }

  Future<List<IconModel>> fetchDataIcon(String uuid) async {
    final url = Uri.parse('https://your-api.com/get-icons?uuid=$uuid');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body) as List<dynamic>;
      return jsonData.map((item) => IconModel.fromJson(item as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load icons');
    }
  }
}
