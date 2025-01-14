import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WPage1 extends StatelessWidget {
  const WPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.all(24), // Thêm padding 24 vào tất cả các cạnh
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Thêm ảnh SVG vào đây
              SvgPicture.asset(
                'lib/assets/svg/Pig.svg',
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Track Your Spending Effortlessly',
                  style: txmain,
                ),
              ),
              const SizedBox(height: 10),
              // Căn lề trái cho văn bản
              const Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Manage your finances easily and set financial goals and monitor your progress',
                  style: texttop,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const TextStyle txmain = TextStyle(
    color: Colors.black,
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle texttop = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );
}
