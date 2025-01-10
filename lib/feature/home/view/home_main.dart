import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Lớp dưới cùng với màu nền
          Positioned.fill(
            child: Container(
              color: const Color(0xFFA561CA), // Lớp nền màu tím
            ),
          ),

          // Lớp trên với hình nền SVG
          Positioned.fill(
            top: -290,
            right: -180,
            child: SvgPicture.asset(
              'lib/assets/svg/Background.svg',
              fit: BoxFit.cover,
            ),
          ),

          // Các phần tử UI nằm trên các lớp trên
          Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 55,
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            'lib/assets/icon/filter_icon.svg',
                          ),
                          const SizedBox(width: 24),
                          SvgPicture.asset(
                            'lib/assets/icon/calendar_icon.svg',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Balance',
                          style: texttop,
                        ),
                        Text(
                          '2.000.000 đ',
                          style: whiteTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 2 / 3,
              decoration: const BoxDecoration(
                color: Color(0xFFFDFDFD),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle whiteTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle texttop = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
}
