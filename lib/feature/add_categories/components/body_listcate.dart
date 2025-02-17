import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testverygood/feature/add_categories/components/content.dart';
import 'package:testverygood/feature/add_categories/view/addcate_main.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
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
                      child: Content(),
                    ),
                  ),
                  // Nội dung cho tab "Income"
                  SizedBox.expand(
                    child: SingleChildScrollView(
                      child: Content(),
                    ),
                  ),
                ],
              ),
            ),
            // Nút thêm category (luôn cố định dưới cùng)
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  // Chuyển đến màn hình AddCateMain
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddCateMain(),),
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
