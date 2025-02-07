import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriesText extends StatefulWidget {
  const CategoriesText({super.key});

  @override
  _CategoriesTextState createState() => _CategoriesTextState();
}

class _CategoriesTextState extends State<CategoriesText> {
  Map<String, dynamic>? customerData;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCustomerData();
  }

  Future<void> fetchCustomerData() async {
    try {
      final response = await http
          .get(Uri.parse('http://blueduck97.ddns.net:5000/api/request'));

      if (response.statusCode == 200) {
        var rawData = response.body;
        print('Raw Data từ API: $rawData');

        var data = json.decode(rawData);

        if (data is List && data.isNotEmpty) {
          setState(() {
            customerData = data.first as Map<String, dynamic>;
          });
        } else if (data is Map<String, dynamic>) {
          setState(() {
            customerData = data;
          });
        } else {
          setState(() {
            errorMessage = 'Dữ liệu từ API không đúng định dạng!';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Lỗi kết nối API: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi khi tải dữ liệu: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: errorMessage.isNotEmpty
          ? Center(
              child:
                  Text(errorMessage, style: const TextStyle(color: Colors.red)))
          : customerData == null
              ? const Center(child: CircularProgressIndicator())
              : _buildUserList(),
    );
  }

  Widget _buildUserList() {
    final userList = customerData?['user1'];

    if (userList == null) {
      return const Center(child: Text('Không có dữ liệu'));
    }

    if (userList is! List) {
      return const Center(
        child: Text('Lỗi: Dữ liệu không phải danh sách'),
      );
    }

    if (userList.isEmpty) {
      return const Center(child: Text('Danh sách rỗng'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // 🔥 Cuộn theo chiều ngang
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: userList
            .where(
                (user) => user is Map<String, dynamic>) // Lọc phần tử đúng kiểu
            .map((user) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ), // Cách nhau một chút
            // ignore: avoid_dynamic_calls
            child: Text('${user["name"] ?? "Không có dữ liệu"}'),
          );
        }).toList(),
      ),
    );
  }
}
