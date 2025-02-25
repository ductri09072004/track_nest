import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:testverygood/bootstrap.dart';
import 'package:testverygood/feature/home/components/icon_content.dart';

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

  Future<void> _loadUUID() async {
    final storedUUID = await storage.read(key: 'unique_id');
    setState(() {
      uuid = storedUUID;
    });
  }

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
    if (uuid == null) {
      return const Center(child: CircularProgressIndicator());
    }

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
            return const Center(child: Text('There are no transactions'));
          }

          final transactions = snapshot.data!
            ..sort(
              (a, b) => (b['date'] as String).compareTo(a['date'] as String),
            );

          var groupedByMonthYear = <String, List<Map<String, dynamic>>>{};
          for (final transaction in transactions) {
            final dateParts = (transaction['date'] as String).split('/');
            if (dateParts.length < 3) {
              continue;
            }
            final monthYear =
                '${dateParts[0]}/${dateParts[1]}/${dateParts[2]}'; // Định dạng MM/yy

            if (!groupedByMonthYear.containsKey(monthYear)) {
              groupedByMonthYear[monthYear] = [];
            }
            groupedByMonthYear[monthYear]!.add(transaction);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: groupedByMonthYear.entries.map((entry) {
              final monthYear = entry.key;
              final transactionsForMonthYear = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: transactionsForMonthYear.map((transaction) {
                  return buildExpenseRow(
                    IconDisplayScreen(cateId: transaction['cate_id'] as String),
                    transaction['cate_id'] as String? ?? 'Không xác định',
                    '${transaction['type'] == 'expense' ? '-' : '+'}${formatCurrency(int.parse(transaction['money'].toString()))}đ',
                    transaction['type'] == 'expense',
                    monthYear,
                  );
                }).toList(),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget buildExpenseRow(
      Widget iconWidget, String title, String price, bool isRed, String date) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFAF5FF), // Màu nền nhẹ
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC084FC)),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            iconWidget,
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: titleicon),
                const SizedBox(height: 4),
                Text(date, style: titledate),
              ],
            ),
            const Spacer(),
            Text(
              price,
              style: isRed ? titleprice : titleprice2,
            ),
          ],
        ),
      ),
    );
  }

  static const TextStyle titleicon = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato',
  );
  static const TextStyle titledate = TextStyle(
    fontSize: 12,
    fontFamily: 'Lato_Light',
    color: Color(0xFF808080),
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
