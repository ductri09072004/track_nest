import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          buildDateSection('Ngày giao dịch', '12/02/2024'),
          const SizedBox(height: 10),
          buildExpenseRow('Chi phí vận chuyển', '200.000đ', true),
          buildExpenseRow('Phí dịch vụ', '50.000đ', false),
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
