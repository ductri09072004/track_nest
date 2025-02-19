import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';

class Content extends StatefulWidget {
  final String categoryType; // Nhận categoryType từ TabBar

  const Content({super.key, required this.categoryType});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final storage = FlutterSecureStorage();
  String? uuid;
  Future<List<Map<String, dynamic>>>? futureData;

  @override
  void initState() {
    super.initState();
    _loadUUID();
  }

  Future<void> _loadUUID() async {
    String? storedUUID = await storage.read(key: 'unique_id');
    if (storedUUID != null) {
      setState(() {
        uuid = storedUUID;
        futureData = fetchData();
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    if (uuid == null) {
      throw Exception('UUID is not loaded');
    }

    final response =
        await http.get(Uri.parse('http://3.26.221.69:5000/api/categories'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final transactions = data.entries
          .map((entry) => entry.value as Map<String, dynamic>)
          .toList();

      return transactions.where((transaction) {
        return transaction['user_id'] == uuid &&
            transaction['type'] == widget.categoryType; // So sánh categoryType
      }).toList();
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 10, bottom: 240),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('Không có dữ liệu cho ${widget.categoryType}'));
          }

          List<Map<String, dynamic>> categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var category = categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                child: Row(
                  children: [
                    Text(category['icon']?.toString() ?? '❓', style: txticon),
                    const SizedBox(width: 6),
                    Text(category['name']?.toString() ?? 'Unknown', style: txt),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã xóa!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        'lib/assets/icon/figma_svg/close.svg',
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              );
            },
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
