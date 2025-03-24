import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testverygood/bootstrap.dart';
import 'package:testverygood/components/Ex_In_btn_Statis.dart';
import 'package:testverygood/features/settings/categories/view/addcate_screen.dart';
import 'package:testverygood/features/settings/categories/widgets/content.dart';
import 'package:testverygood/features/settings/subcription/view/subcription_main.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  State<BodyMain> createState() => _BodyMainState();
}

Future<String?> loadTypeId() async {
  return storage.read(key: 'type_id');
}

void navigateToTargetPage(BuildContext context) async {
  String? typeId = await storage.read(key: 'type_id');

  if (typeId == 'free') {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UpgradeAccountPage()),
    );
  } else if (typeId == 'premium') {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AddCateMain()),
    );
  }
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
              child: Stack(
                clipBehavior:
                    Clip.none, // Để hiển thị chữ PRO nằm ngoài icon nếu cần
                children: [
                  GestureDetector(
                    onTap: () {
                      navigateToTargetPage(context);
                    },
                    child: SvgPicture.asset(
                      'lib/assets/icon/active_navbar/addA_icon.svg',
                      width: 60, // Tuỳ chỉnh kích thước icon nếu cần
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
