import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';

class Content extends StatefulWidget {
  // Nhận categoryType từ TabBar

  const Content({super.key, required this.categoryType});
  final String categoryType;

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final storage = const FlutterSecureStorage();
  String? uuid;
  Future<Map<String, dynamic>>? futureData;

  @override
  void initState() {
    super.initState();
    _loadUUID();
  }

  Future<void> _loadUUID() async {
    var storedUUID = await storage.read(key: 'unique_id');
    if (storedUUID != null) {
      setState(() {
        uuid = storedUUID;
        futureData = fetchData();
      });
    }
  }

  Future<Map<String, dynamic>> fetchData() async {
    if (uuid == null) {
      throw Exception('UUID is not loaded');
    }

    final response =
        await http.get(Uri.parse('http://3.26.221.69:5000/api/categories'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      // Lọc dữ liệu theo user_id và categoryType
      return data.map((key, value) {
        return MapEntry(key, {
          'id': key, // Giữ ID từ key của Map
          ...(value is Map<String, dynamic>
              ? value
              : {}), // Kiểm tra kiểu trước khi spread
        });
      })
        ..removeWhere(
          (key, value) =>
              value['user_id'] != uuid || value['type'] != widget.categoryType,
        );
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://3.26.221.69:5000/api/categories/$categoryId'),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        setState(() {
          futureData = fetchData(); // Cập nhật danh sách sau khi xóa
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Delete success!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Delete failed: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 10, bottom: 240),
      child: FutureBuilder<Map<String, dynamic>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data for ${widget.categoryType}'),
            );
          }

          var categories = snapshot.data!;
          return ListView(
            children: categories.entries.map((entry) {
              final category = entry.value;
              var id = entry.key; // Lấy ID trực tiếp từ key của Map

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                child: Row(
                  children: [
                    Text(category['icon']?.toString() ?? '❓', style: txticon),
                    const SizedBox(width: 6),
                    Text(category['name']?.toString() ?? 'Unknown', style: txt),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        await deleteCategory(id); // Xóa theo ID từ key
                      },
                      child: SvgPicture.asset(
                        'lib/assets/icon/figma_svg/close.svg',
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  static const TextStyle txticon = TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontFamily: 'Lato',
  );

  static const TextStyle txt = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Lato_Regular',
  );
}
