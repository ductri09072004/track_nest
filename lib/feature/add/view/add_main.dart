import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/feature/scanbill/app.dart';
import 'package:testverygood/feature/scanbill/view/scanphoto.dart';
import 'package:testverygood/feature/split/app.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Lớp nền màu tím
          Positioned.fill(
            child: Container(
              color: const Color(0xFFA561CA),
            ),
          ),
          // Hình nền SVG
          Positioned.fill(
            top: -290,
            right: -180,
            child: SvgPicture.asset(
              'lib/assets/svg/Background.svg',
              fit: BoxFit.cover,
            ),
          ),
          // Nội dung chính với cuộn
          SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 55,
                    left: 20,
                    right: 20,
                    bottom: 40,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'ADD ITEM TO EXPENSES',
                        style: texttop,
                      ),
                    ],
                  ),
                ),
                // Nút 1: Scan Bill
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
                // Nút 2: Add Manually
                buildSettingItem(
                  context: context,
                  iconPath: 'lib/assets/icon/add_icon/add_icon.svg',
                  label: 'ADD MANUALLY',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplitPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                // Nút 3: Add Split Manually
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

                const SizedBox(height: 104),
              ],
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
      onTap: onTap, // Xử lý sự kiện nhấn
      child: Container(
        width: double.infinity, // Chiếm toàn bộ chiều ngang
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
            // Icon SVG
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(height: 10),
            // Text
            Text(
              label,
              style: txtbtn,
            ),
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

  static const TextStyle texttop = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Lato',
  );
}

// Các trang chuyển tiếp
class ScanBillPage extends StatelessWidget {
  const ScanBillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Bill')),
      body: const Center(child: Text('Scan Bill Page')),
    );
  }
}

class AddManuallyPage extends StatelessWidget {
  const AddManuallyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Manually')),
      body: const Center(child: Text('Add Manually Page')),
    );
  }
}

class AddSplitManuallyPage extends StatelessWidget {
  const AddSplitManuallyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Split Manually')),
      body: const Center(child: Text('Add Split Manually Page')),
    );
  }
}
