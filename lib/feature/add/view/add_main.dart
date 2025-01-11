import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          // Nội dung chính
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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

              // Ô chữ nhật 1
              buildSettingItem(
                iconPath: 'lib/assets/icon/add_icon/scan_icon.svg',
                label: 'SCAN BILL',
              ),
              const SizedBox(height: 10),
              // Ô chữ nhật 2
              buildSettingItem(
                iconPath: 'lib/assets/icon/add_icon/add_icon.svg',
                label: 'ADD MANUALLY',
              ),
              const SizedBox(height: 10),
              // Ô chữ nhật 3
              buildSettingItem(
                iconPath: 'lib/assets/icon/add_icon/add_icon.svg',
                label: 'ADD SPLIT MANUALLY',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Hàm xây dựng ô chữ nhật
  Widget buildSettingItem({
    required String iconPath,
    required String label,
  }) {
    return Container(
      width: double.infinity, // Chiếm toàn bộ chiều ngang
      margin: const EdgeInsets.symmetric(horizontal: 44),
      padding: const EdgeInsets.symmetric(vertical: 54),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
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
