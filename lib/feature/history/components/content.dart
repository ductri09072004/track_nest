import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDateSection('Eating', '24/12/2024'),
          const SizedBox(height: 10),
          buildExpenseRow('Tram payed', '100.000d', true),
          const SizedBox(height: 10), // Thêm khoảng cách
          buildExpenseRow('Tram payed', '100.000d', false),
          const SizedBox(height: 10), // Thêm khoảng cách
          buildExpenseRow('Tram payed', '100.000d', false),
          const SizedBox(height: 12),
          buildDateSection('Playing', '24/12/2024'),
          const SizedBox(height: 10),
          buildExpenseRow('Tram payed', '100.000d', true),
          const SizedBox(height: 10), // Thêm khoảng cách
          buildExpenseRow('Tram payed', '100.000d', false),
          const SizedBox(height: 10), // Thêm khoảng cách
          buildExpenseRow('Tram payed', '100.000d', false),
        ],
      ),
    );
  }

  Widget buildDateSection(String title, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset('lib/assets/icon/home_icon/girl_icon.svg'),
            Text(
              title,
              style: titleText,
            ),
            const Spacer(),
            Text(
              date,
              style: titleText,
            ),
          ],
        ),
        Container(
          height: 2,
          color: const Color(0xFF000000),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget buildExpenseRow(String title, String price, bool isRed) {
    return Row(
      children: [
        Text(title, style: titleicon),
        const Spacer(),
        Text(
          price,
          style: isRed ? titleprice : titleprice2,
        ),
      ],
    );
  }

  static const TextStyle titleText = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
  static const TextStyle titleicon = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
  );
  static const TextStyle titleicon2 = TextStyle(
    fontSize: 12,
    fontFamily: 'Lato_Light',
  );
  static const TextStyle titleprice = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: Color(0xFFF44336),
  );
  static const TextStyle titleprice2 = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: Color(0xFF5CB338),
  );
}
