import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testverygood/components/Ex_In_btn_Satis.dart';
import 'package:testverygood/features/settings/categories/widgets/content.dart';
import 'package:testverygood/features/settings/categories/view/addcate_main.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  State<BodyMain> createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  int selectedIndex = 0; // Khai báo biến selectedIndex
  final PageController _pageController =
      PageController(); // Khai báo PageController

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            ExInBtnStatis(
              labels: const ['Expenses', 'Income'],
              onToggle: (index) {
                setState(() {
                  selectedIndex = index;
                });
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: const [
                  SizedBox.expand(
                    child: SingleChildScrollView(
                      child: Content(categoryType: 'expense'),
                    ),
                  ),
                  SizedBox.expand(
                    child: SingleChildScrollView(
                      child: Content(categoryType: 'income'),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCateMain(),
                    ),
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
}
