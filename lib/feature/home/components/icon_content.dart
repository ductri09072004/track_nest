import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class IconDisplayScreen extends StatefulWidget {
  final String cateId;

  const IconDisplayScreen({super.key, required this.cateId});

  @override
  _IconDisplayScreenState createState() => _IconDisplayScreenState();
}

class _IconDisplayScreenState extends State<IconDisplayScreen> {
  final storage = FlutterSecureStorage();
  String? uuid;
  List<Map<String, dynamic>> icons = [];

  @override
  void initState() {
    super.initState();
    _loadUUID();
  }

  Future<void> _loadUUID() async {
    final storedUUID = await storage.read(key: 'unique_id');
    if (storedUUID != null) {
      setState(() {
        uuid = storedUUID;
      });
      await _fetchDataIcon(storedUUID);
    }
  }

  Future<void> _fetchDataIcon(String uuid) async {
    try {
      final response =
          await http.get(Uri.parse('http://3.26.221.69:5000/api/categories'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final iconList = data.entries
            .map((entry) => entry.value as Map<String, dynamic>)
            .toList();

        setState(() {
          icons = iconList.where((icon) => icon['user_id'] == uuid).toList();
        });
      } else {
        throw Exception('Không thể tải dữ liệu');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tìm icon có 'name' trùng với cateId
    final matchingIcon = icons.firstWhere(
      (icon) => icon['name'] == widget.cateId,
      orElse: () => {
        'icon': '',
      },
    );

    return Text(
      matchingIcon['icon'] as String, // Hiển thị icon dưới dạng text
      style: const TextStyle(fontSize: 30),
    );
  }
}
