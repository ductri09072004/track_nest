import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WPage2 extends StatelessWidget {
  const WPage2({super.key});

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
                'lib/assets/svg/human_split.svg',
              ),
              const SizedBox(height: 20),
              // Căn lề trái cho văn bản
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Split Money Easily',
                  style: txmain,
                ),
              ),
              const SizedBox(height: 10),
              // Căn lề trái cho văn bản
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Split the bill with your friends fast and effortlessly and track shared costs',
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
