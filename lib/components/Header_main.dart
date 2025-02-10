import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/components/date.dart'; // Import HorizontalList từ đây

class HeaderMain extends StatelessWidget {
  final bool showBalance;
  final bool showIcons; // Kiểm soát hiển thị các icon
  final bool showHorizontalList; // Kiểm soát hiển thị HorizontalList
  final bool showTitle;

  const HeaderMain({
    super.key,
    this.showBalance = true, // Mặc định hiển thị balance
    this.showIcons = true, // Mặc định hiển thị icon
    this.showHorizontalList = true, // Mặc định hiển thị HorizontalList
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: const Color(0xFFA561CA),
          ),
        ),
        Positioned.fill(
          top: -290,
          right: -180,
          child: SvgPicture.asset(
            'lib/assets/svg/Background.svg',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 55,
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  if (showIcons)
                    SvgPicture.asset(
                      'lib/assets/icon/home_icon/calendar_icon.svg',
                    )
                  else
                    const SizedBox(width: 24), // Kích thước tương tự icon
                  const SizedBox(width: 24),
                  if (showIcons)
                    SvgPicture.asset(
                      'lib/assets/icon/home_icon/search_icon.svg',
                    )
                  else
                    const SizedBox(width: 24),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (showHorizontalList) // Kiểm tra điều kiện hiển thị HorizontalList
              const HorizontalList(),
            const SizedBox(height: 30),
            if (showBalance) // Kiểm tra điều kiện hiển thị balance
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Balance',
                      style: texttop,
                    ),
                    Text(
                      '2.000.000 đ',
                      style: whiteTextStyle,
                    ),
                  ],
                ),
              ),
            if (showTitle) // Kiểm tra điều kiện hiển thị balance
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Setting',
                      style: texttitle,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  static const TextStyle whiteTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    fontFamily: 'Lato',
  );

  static const TextStyle texttop =
      TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato');
  static const TextStyle texttitle =
      TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Lato');
}

