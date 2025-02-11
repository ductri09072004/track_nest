import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testverygood/feature/add_categories/components/content.dart';
import 'package:testverygood/feature/add_categories/view/addcate_main.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    // return Positioned(
    //     top: MediaQuery.of(context).size.height,
    //     left: 0,
    //     right: 0,
    //     child: Container(
    //       height: MediaQuery.of(context).size.height,
    //       // padding: const EdgeInsets.only(top: 12),
    //       // padding: const EdgeInsets.only(bottom: 110),
    //       child: DefaultTabController(
    //         length: 2, // Số lượng tab
    //         child: Column(
    //           children: [
    //             const TabBar(
    //               indicatorPadding: EdgeInsets.symmetric(horizontal: -44),
    //               indicator: BoxDecoration(
    //                 border: Border(
    //                   bottom: BorderSide(
    //                     color: Color(0xFF791CAC), // Màu của indicator
    //                     width: 3,
    //                   ),
    //                 ),
    //               ),
    //               indicatorSize: TabBarIndicatorSize.label,
    //               labelColor: Colors.black,
    //               unselectedLabelColor: Colors.grey,
    //               labelStyle: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 14,
    //                 fontFamily: 'lato',
    //               ),
    //               unselectedLabelStyle: TextStyle(
    //                 fontWeight: FontWeight.normal,
    //                 fontSize: 14,
    //                 fontFamily: 'lato',
    //               ),
    //               // Thêm dòng này để loại bỏ viền đen mặc định
    //               splashFactory: NoSplash.splashFactory,
    //               indicatorColor: Colors.transparent,
    //               tabs: [
    //                 Tab(text: 'Expense'),
    //                 Tab(text: 'Income'),
    //               ],
    //             ),
    //             const Expanded(
    //               child: TabBarView(
    //                 children: [
    //                   // Nội dung cho tab "Income"
    //                   Column(
    //                     children: [
    //                       Expanded(
    //                         child: SingleChildScrollView(
    //                           padding: EdgeInsets.only(bottom: 110),
    //                           child: Content(),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   // Nội dung cho tab "Expenses"
    //                   Column(
    //                     children: [
    //                       Expanded(
    //                         child: SingleChildScrollView(
    //                           padding: EdgeInsets.only(bottom: 110),
    //                           child:
    //                               Content(), // Có thể thay đổi nội dung khác nếu cần
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const Spacer(),
    //             Align(
    //               alignment: Alignment.bottomCenter,
    //               child: GestureDetector(
    //                 onTap: () {
    //                   // Chuyển đến màn hình AddGroupPage
    //                   Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => const AddCateMain(),),
    //                   );
    //                 },
    //                 child: SvgPicture.asset(
    //                   'lib/assets/icon/active_navbar/addA_icon.svg',
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );

    return Container(
      height: MediaQuery.of(context).size.height,
      // padding: const EdgeInsets.only(top: 12),
      child: DefaultTabController(
        length: 2, // Số lượng tab
        child: Column(
          children: [
            const TabBar(
              indicatorPadding: EdgeInsets.symmetric(horizontal: -44),
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF791CAC), // Màu của indicator
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
            const Expanded(
              child: TabBarView(
                children: [
                  // Nội dung cho tab "Expense"
                  SizedBox.expand(
                    child: SingleChildScrollView(
                      // padding: EdgeInsets.only(bottom: 210),
                      child: Content(),
                    ),
                  ),
                  // Nội dung cho tab "Income"
                  SizedBox.expand(
                    child: SingleChildScrollView(
                      // padding: EdgeInsets.only(bottom: 210),
                      child: Content(),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(width: 16,),
            // Nút thêm category (luôn cố định dưới cùng)
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  // Chuyển đến màn hình AddCateMain
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddCateMain()),
                  );
                },
                child: SvgPicture.asset(
                  'lib/assets/icon/active_navbar/addA_icon.svg',
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  static const TextStyle txtcate = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Lato',
  );

  static const TextStyle txtmem = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Lato_Regular',
  );
}
