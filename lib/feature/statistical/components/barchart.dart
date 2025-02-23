import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:testverygood/bootstrap.dart';

class Barchart extends StatefulWidget {
  const Barchart({required this.tabType, required this.onDataReady, super.key});
  final String tabType;
  final Function(Map<String, double>) onDataReady;

  @override
  _BarchartState createState() => _BarchartState();
}

class _BarchartState extends State<Barchart> {
  List<Map<String, dynamic>> transactions = [];
  String errorMessage = '';
  String? uuid;
  bool isLoading = true;

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
        final data = json.decode(response.body) as Map<String, dynamic>;
        final allTransactions = data.entries
            .map((entry) => entry.value as Map<String, dynamic>)
            .toList();

        var filteredTransactions = allTransactions
            .where(
              (transaction) =>
                  transaction['user_id'] == uuid &&
                  transaction['type'] == widget.tabType,
            )
            .toList();

        setState(() {
          transactions = filteredTransactions;
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
    return Positioned(
      top: 147,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 222,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
                  ? Center(
                      child: Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    )
                  : transactions.isEmpty
                      ? const Center(child: Text('There are no transactions'))
                      : _buildChartWithLegend(),
        ),
      ),
    );
  }

  Widget _buildChartWithLegend() {
    var totalMoney = transactions.fold<double>(
      0.0,
      (sum, transaction) => sum + (transaction['money'] as num).toDouble(),
    );

    var categoryData = <String, Map<String, double>>{};
    for (final transaction in transactions) {
      var category = transaction['cate_id'].toString();
      var money = (transaction['money'] as num).toDouble();

      if (!categoryData.containsKey(category)) {
        categoryData[category] = {'money': 0, 'percentage': 0};
      }

      categoryData[category]!['money'] =
          (categoryData[category]!['money'] ?? 0) + money;
    }

    // Tính phần trăm từng loại
    if (totalMoney > 0) {
      categoryData.forEach((key, value) {
        value['percentage'] = (value['money']! / totalMoney) * 100;
      });
    }

    // Truyền dữ liệu bao gồm cả phần trăm
    widget.onDataReady(
        categoryData.map((key, value) => MapEntry(key, value['percentage']!)));

    final List<Color> colors = Colors.primaries;

    var sections = categoryData.entries.map((entry) {
      var index = categoryData.keys.toList().indexOf(entry.key);
      var money = entry.value['money']!;
      var percentage = entry.value['percentage']!;

      return PieChartSectionData(
        value: money,
        title: '${percentage.toStringAsFixed(1)}%',
        color: colors[index % colors.length],
        radius: 30,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 40),
        Expanded(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  child: PieChart(
                    PieChartData(
                      sections: sections,
                      centerSpaceRadius: 60,
                      sectionsSpace: 2,
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'lato_semi',
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${NumberFormat("#,###", "vi_VN").format(totalMoney)} đ',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categoryData.entries.map((entry) {
              var index = categoryData.keys.toList().indexOf(entry.key);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: colors[index % colors.length],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(entry.key),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
