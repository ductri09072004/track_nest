import 'package:flutter/material.dart';
import 'package:testverygood/feature/home/components/expense_content.dart';
import 'package:testverygood/feature/home/components/income_content.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 3,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 2 / 3,
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(36),
            topRight: Radius.circular(36),
          ),
        ),
        child: const DefaultTabController(
          length: 2, // Số lượng tab
          child: Column(
            children: [
              TabBar(
                indicatorPadding: EdgeInsets.symmetric(horizontal: -44),
                indicator: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFF791CAC), // Màu của indicator
                      width: 4,
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
                // Thêm dòng này để loại bỏ viền đen mặc định
                splashFactory: NoSplash.splashFactory,
                tabs: [
                  Tab(text: 'Expense'),
                  Tab(text: 'Income'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ExpContent(),
                    IncomeContent(),
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
