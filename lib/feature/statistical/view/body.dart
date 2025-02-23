import 'package:flutter/material.dart';
import 'package:testverygood/feature/statistical/components/barchart.dart';
import 'package:testverygood/feature/statistical/components/content.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  _BodyMainState createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  Map<String, double> expenseData = {};
  Map<String, double> incomeData = {};

  void _updateExpenseData(Map<String, double> data) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && data != expenseData) {
        setState(() {
          expenseData = data;
        });
      }
    });
  }

  void _updateIncomeData(Map<String, double> data) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && data != incomeData) {
        setState(() {
          incomeData = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var expenseList = expenseData.entries.map((entry) {
      return ExpenseData(
        title: entry.key,
        percent: '${entry.value.toStringAsFixed(2)}%',
        price: '${entry.value.toStringAsFixed(0)}đ',
      );
    }).toList();

    var incomeList = incomeData.entries.map((entry) {
      return ExpenseData(
        title: entry.key,
        percent: '${entry.value.toStringAsFixed(2)}%',
        price: '${entry.value.toStringAsFixed(0)}đ',
      );
    }).toList();

    return Positioned(
      top: MediaQuery.of(context).size.height / 5,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(bottom: 110),
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD),
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                indicatorPadding: EdgeInsets.symmetric(horizontal: -44),
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF791CAC),
                      width: 3,
                    ),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  fontFamily: 'lato',
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  fontFamily: 'lato',
                ),
                splashFactory: NoSplash.splashFactory,
                indicatorColor: Colors.transparent,
                tabs: [
                  Tab(text: 'Expense'),
                  Tab(text: 'Income'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: Barchart(
                            tabType: 'expense',
                            onDataReady: _updateExpenseData,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(bottom: 110),
                            child: Content(data: expenseList), // ✅ Đã sửa
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: Barchart(
                            tabType: 'income',
                            onDataReady: _updateIncomeData,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(bottom: 110),
                            child: Content(data: incomeList), // ✅ Đã sửa
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
