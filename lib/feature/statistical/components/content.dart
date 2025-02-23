import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:testverygood/bootstrap.dart';

class ExpenseData {
  ExpenseData({
    required this.percent,
    required this.title,
    required this.price,
  });

  final String percent;
  final String title;
  final String price;
}

class Content extends StatefulWidget {
  const Content({required this.tabType, super.key});
  final String tabType;

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<ExpenseData> data = [];
  bool isLoading = true;
  String errorMessage = '';
  String? uuid;

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

    if (uuid != null) {
      await fetchData();
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response =
          await http.get(Uri.parse('http://3.26.221.69:5000/api/transactions'));

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body) as Map<String, dynamic>;
        final transactions = decodedData.entries
            .map((entry) => entry.value as Map<String, dynamic>)
            .where(
              (transaction) =>
                  transaction['user_id'] == uuid &&
                  transaction['type'] == widget.tabType,
            )
            .toList();

        var categoryData = <String, double>{};
        double totalMoney = 0.0;

        for (final transaction in transactions) {
          var category = transaction['cate_id'].toString();
          var money = (transaction['money'] as num).toDouble();

          totalMoney += money;
          categoryData[category] = (categoryData[category] ?? 0) + money;
        }

        List<ExpenseData> formattedData = categoryData.entries.map((entry) {
          double percentage = (entry.value / totalMoney) * 100;
          return ExpenseData(
            percent: '${percentage.toStringAsFixed(1)}%',
            title: entry.key, // Thay thế bằng tên danh mục nếu có
            price: '${NumberFormat("#,###", "vi_VN").format(entry.value)} VND',
          );
        }).toList();

        setState(() {
          data = formattedData;
          isLoading = false;
        });
      } else {
        throw Exception('Không thể tải dữ liệu');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi khi tải dữ liệu: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage,
                      style: const TextStyle(color: Colors.red)))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data
                      .map(
                        (expense) => Column(
                          children: [
                            buildDateSection(
                              expense.percent,
                              expense.title,
                              expense.price,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      )
                      .toList(),
                ),
    );
  }

  Widget buildDateSection(String percent, String title, String price) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF537FF1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(percent, style: perText),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titleText),
          ],
        ),
        const Spacer(),
        Text(price, style: titlePrice),
      ],
    );
  }

  static const TextStyle titleText = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );

  static const TextStyle perText = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: Color(0xFFFFFFFF),
  );

  static const TextStyle titlePrice = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
}
