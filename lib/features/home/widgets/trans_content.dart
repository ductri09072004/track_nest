import 'package:flutter/material.dart';
import 'package:testverygood/data/data_api/home_data_api.dart';
import 'package:testverygood/features/home/widgets/icon_content.dart';
import 'package:testverygood/features/transaction/edit_trans/view/edit_main.dart';
import 'package:testverygood/assets/core/appcolor.dart';

class TransContent extends StatefulWidget {
  const TransContent({super.key});

  @override
  _TransContentState createState() => _TransContentState();
}

class _TransContentState extends State<TransContent> {
  String? uuid;
  late Future<List<Map<String, dynamic>>> futureData;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final storedUUID = await loadUUID();
    setState(() {
      uuid = storedUUID;
      futureData = fetchData(uuid);
    });
  }

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  void navigateToDetailPage(BuildContext context, String title, Widget icon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMain(
          transid: title,
          icon: icon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (uuid == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

          final transactions = snapshot.data!;
          transactions.sort((a, b) {
            DateTime dateA = _parseDate(a['date'] as String);
            DateTime dateB = _parseDate(b['date'] as String);
            return dateB.compareTo(dateA);
          });

          var groupedByMonthYear = <String, List<Map<String, dynamic>>>{};
          for (final transaction in transactions) {
            final dateParts = (transaction['date'] as String).split('/');
            if (dateParts.length < 3) continue;

            final monthYear = '${dateParts[0]}/${dateParts[1]}/${dateParts[2]}';

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
                    transaction['cate_id'] as String? ?? 'null',
                    '${transaction['type'] == 'expense' ? '-' : '+'}${formatCurrency(int.parse(transaction['money'].toString()))} VND',
                    transaction['type'] == 'expense',
                    monthYear,
                    transaction['trans_id'] as String? ?? 'null',
                  );
                }).toList(),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  DateTime _parseDate(String dateString) {
    List<String> parts = dateString.split('/');
    if (parts.length < 3) return DateTime(2000, 1, 1);
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  Widget buildExpenseRow(Widget iconWidget, String title, String price,
      bool isRed, String date, String trans) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          navigateToDetailPage(context, trans, iconWidget);
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFDBEAFE),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.blue),
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
      ),
    );
  }

  static const TextStyle titleicon = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
  static const TextStyle titledate = TextStyle(
    fontSize: 12,
    fontFamily: 'Lato',
    color: AppColor.blackLighter,
  );
  static const TextStyle titleprice = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato',
    color: Color(0xFFF44336),
  );
  static const TextStyle titleprice2 = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato',
    color: Color(0xFF5CB338),
  );
}
