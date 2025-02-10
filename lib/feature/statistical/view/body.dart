import 'package:flutter/material.dart';
import 'package:testverygood/feature/statistical/components/barchart.dart';
import 'package:testverygood/feature/statistical/components/content.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    // return Positioned(
    //   top: MediaQuery.of(context).size.height / 5,
    //   left: 0,
    //   right: 0,
    //   child: Container(
    //     height: MediaQuery.of(context).size.height,
    //     padding: const EdgeInsets.only(top: 12, bottom: 110),
    //     decoration: const BoxDecoration(
    //       color: Color(0xFFFDFDFD),
    //     ),
    //     child: const Column(
    //       children: [
    //         SizedBox(
    //           height: 250, // Chiều cao cố định của BarChart
    //           child: Barchart(),
    //         ),
    //         Expanded(
    //           child: SingleChildScrollView(
    //             padding: EdgeInsets.only(bottom: 110),
    //             child: Content(),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );


    return Positioned(
      top: MediaQuery.of(context).size.height / 5,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 12, bottom: 110),
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD),
        ),
        child: const DefaultTabController(
          length: 2, // Số lượng tab
          child: Column(
            children: [
              TabBar(
                indicatorPadding: EdgeInsets.symmetric(horizontal: -44),
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
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
                indicatorColor: Colors.transparent,
                tabs: [
                  Tab(text: 'Expense'),
                  Tab(text: 'Income'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Nội dung cho tab "Income"
                    Column(
                      children: [
                        SizedBox(
                          height: 250, // Giữ cố định BarChart
                          child: Barchart(),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(bottom: 110),
                            child: Content(),
                          ),
                        ),
                      ],
                    ),
                    // Nội dung cho tab "Expenses"
                    Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: Barchart(), // Có thể thay bằng BarChart khác nếu cần
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.only(bottom: 110),
                            child: Content(), // Có thể thay đổi nội dung khác nếu cần
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
