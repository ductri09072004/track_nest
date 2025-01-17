import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/components/date.dart';

class HeaderMain extends StatelessWidget {
  final bool showBalance;

  const HeaderMain({
    super.key,
    this.showBalance = true, // Mặc định hiển thị balance
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
                  SvgPicture.asset(
                    'lib/assets/icon/home_icon/setting_icon.svg',
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'lib/assets/icon/home_icon/calendar_icon.svg',
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  SvgPicture.asset(
                    'lib/assets/icon/home_icon/search_icon.svg',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const HorizontalList(), // HorizontalList không có padding
            const SizedBox(height: 30),
            if (showBalance) // Kiểm tra điều kiện
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
}
