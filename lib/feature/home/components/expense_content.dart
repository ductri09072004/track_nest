import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:testverygood/bootstrap.dart';

class ExpContent extends StatefulWidget {
  const ExpContent({super.key});

  @override
  _ExpContentState createState() => _ExpContentState();
}

class _ExpContentState extends State<ExpContent> {
  String? uuid;
  late Future<List<Map<String, dynamic>>> futureData;

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  @override
  void initState() {
    super.initState();
    _loadUUID();
  }

  // Hàm này chỉ tải UUID và trigger lại setState để cập nhật khi UUID có giá trị
  Future<void> _loadUUID() async {
    final storedUUID = await storage.read(key: 'unique_id');
    setState(() {
      uuid = storedUUID;
    });
  }

  // Hàm để fetch dữ liệu từ API
  Future<List<Map<String, dynamic>>> fetchData() async {
    if (uuid == null) {
      throw Exception('UUID is not loaded');
    }

    final response =
        await http.get(Uri.parse('http://3.26.221.69:5000/api/transactions'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final transactions = data.entries
          .map((entry) => entry.value as Map<String, dynamic>)
          .toList();

      return transactions.where((transaction) {
        return transaction['user_id'] == uuid;
      }).toList();
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nếu uuid chưa được load, hiển thị CircularProgressIndicator
    if (uuid == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Gọi API và fetch data sau khi UUID có giá trị
    futureData = fetchData();

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có dữ liệu'));
          }

          final transactions = snapshot.data!
            ..sort(
              (a, b) => (b['date'] as String).compareTo(a['date'] as String),
            );

          // Nhóm giao dịch theo ngày
          var groupedByDate = <String, List<Map<String, dynamic>>>{};
          for (final transaction in transactions) {
            final date = transaction['date'] as String;
            if (!groupedByDate.containsKey(date)) {
              groupedByDate[date] = [];
            }
            groupedByDate[date]!.add(transaction);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: groupedByDate.entries.map((entry) {
              final date = entry.key;
              final transactionsForDate = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDateSection(date),
                  ...transactionsForDate.map((transaction) {
                    return buildExpenseRow(
                      transaction['cate_id'] as String? ?? 'Không xác định',
                      '${formatCurrency(int.parse(transaction['money'].toString()))}đ',
                      transaction['type'] == 'expense',
                    );
                  }),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget buildDateSection(String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: titleText,
        ),
        const SizedBox(height: 12),
        Container(
          height: 2,
          color: const Color(0xFFD9D9D9),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget buildExpenseRow(String title, String price, bool isRed) {
    return Row(
      children: [
        SvgPicture.asset('lib/assets/icon/home_icon/girl_icon.svg'),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titleicon),
          ],
        ),
        const Spacer(),
        Text(
          price,
          style: isRed ? titleprice : titleprice2,
        ),
      ],
    );
  }

  static const TextStyle titleText = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
  static const TextStyle titleicon = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato',
  );
  static const TextStyle titleprice = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: Color(0xFFF44336),
  );
  static const TextStyle titleprice2 = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: Color(0xFF5CB338),
  );
}
