import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/features/transactions/scanbill/view/scanphoto.dart';
import 'package:testverygood/features/groupsplit/addsplit/app.dart';
import 'package:testverygood/features/transactions/transactrion/app.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hình nền màu tím
          Positioned.fill(
            child: Container(
              color: const Color(0xFFA561CA),
            ),
          ),
          // Hình nền SVG chiếm toàn bộ màn hình
          Positioned.fill(
            child: SvgPicture.asset(
              'lib/assets/svg/Background.svg',
              fit: BoxFit.cover,
            ),
          ),
          // Nội dung chính
          SafeArea(
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height, // Chiếm toàn bộ chiều cao
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildSettingItem(
                            context: context,
                            iconPath: 'lib/assets/icon/add_icon/scan_icon.svg',
                            label: 'SCAN BILL',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImagePickerScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          buildSettingItem(
                            context: context,
                            iconPath: 'lib/assets/icon/add_icon/add_icon.svg',
                            label: 'ADD MANUALLY',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TransactionMain(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          buildSettingItem(
                            context: context,
                            iconPath: 'lib/assets/icon/add_icon/add_icon.svg',
                            label: 'ADD SPLIT MANUALLY',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SplitPage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  // Chỉnh khoảng cách dưới cùng
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm xây dựng ô chữ nhật
  Widget buildSettingItem({
    required BuildContext context,
    required String iconPath,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 44),
        padding: const EdgeInsets.symmetric(vertical: 54),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(height: 10),
            Text(label, style: txtbtn),
          ],
        ),
      ),
    );
  }

  static const TextStyle txtbtn = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: 'Lato',
  );
}
