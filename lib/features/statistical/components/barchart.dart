import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:testverygood/data/data_api/barchart_data_api.dart';

class Barchart extends StatefulWidget {
  const Barchart({required this.tabType, super.key});
  final String tabType;

  @override
  _BarchartState createState() => _BarchartState();
}

class _BarchartState extends State<Barchart> {
  final DataService dataService = DataService();
  List<Map<String, dynamic>> transactions = [];
  String errorMessage = '';
  String? uuid;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      uuid = await dataService.loadUUID();
      if (uuid != null) {
        final data = await dataService.fetchData(uuid!, widget.tabType);
        if (mounted) {
          setState(() {
            transactions = data;
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Lỗi khi tải dữ liệu: $e';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
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
    ));
  }

  Widget _buildChartWithLegend() {
    final totalMoney = transactions.fold<double>(
      0,
      (sum, transaction) => sum + (transaction['money'] as num).toDouble(),
    );

    final categoryData = <String, Map<String, double>>{};
    for (final transaction in transactions) {
      final category = transaction['cate_id'].toString();
      final money = (transaction['money'] as num).toDouble();

      if (!categoryData.containsKey(category)) {
        categoryData[category] = {'money': 0, 'percentage': 0};
      }

      categoryData[category]!['money'] =
          (categoryData[category]!['money'] ?? 0) + money;
    }

    if (totalMoney > 0) {
      categoryData.forEach((key, value) {
        value['percentage'] = (value['money']! / totalMoney) * 100;
      });
    }

    final pastelColors = <Color>[
      const Color(0xFFFF928A),
      const Color(0xFF3CC3DF),
      const Color(0xFFFFAE4C),
      const Color(0xFF537FF1),
      const Color(0xFF6FD195),
      const Color(0xFF8979FF),
    ];

    final sections = categoryData.entries.map((entry) {
      final index = categoryData.keys.toList().indexOf(entry.key);
      final money = entry.value['money']!;
      final percentage = entry.value['percentage']!;

      return PieChartSectionData(
        value: money,
        title: '${percentage.toStringAsFixed(0)}%',
        color: pastelColors[index % pastelColors.length],
        radius: 35,
        titleStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  child: PieChart(
                    PieChartData(
                      sections: sections,
                      centerSpaceRadius: 80,
                      sectionsSpace: 0,
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
      ],
    );
  }
}
