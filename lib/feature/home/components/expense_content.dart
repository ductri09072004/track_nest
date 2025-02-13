import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpContent extends StatelessWidget {
  const ExpContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDateSection('6 December 2025'),
          buildExpenseRow('Eating', 'Budget: 300.000d', '100.000d', true),
          buildExpenseRow('Friends', 'Budget: 300.000d', '100.000d', false),
          const SizedBox(height: 12),
          buildDateSection('6 December 2025'),
          buildExpenseRow('Eating', 'Budget: 300.000d', '100.000d', true),
          buildExpenseRow('Friends', 'Budget: 300.000d', '100.000d', false),
          const SizedBox(height: 12),
          buildDateSection('6 December 2025'),
          buildExpenseRow('Eating', 'Budget: 300.000d', '100.000d', true),
          buildExpenseRow('Friends', 'Budget: 300.000d', '100.000d', false),
          const SizedBox(height: 12),
          buildDateSection('6 December 2025'),
          buildExpenseRow('Eating', 'Budget: 300.000d', '100.000d', true),
          buildExpenseRow('Friends', 'Budget: 300.000d', '100.000d', false),
          const SizedBox(height: 12),
          buildDateSection('6 December 2025'),
          buildExpenseRow('Eating', 'Budget: 300.000d', '100.000d', true),
          buildExpenseRow('Friends', 'Budget: 300.000d', '100.000d', false),
          const SizedBox(height: 12),
          buildDateSection('6 December 2025'),
          buildExpenseRow('Eating', 'Budget: 300.000d', '100.000d', true),
          buildExpenseRow('Friends', 'Budget: 300.000d', '100.000d', false),
          const SizedBox(height: 12),
          buildDateSection('6 December 2025'),
          buildExpenseRow('Eating', 'Budget: 300.000d', '100.000d', true),
          buildExpenseRow('Friends', 'Budget: 300.000d', '100.000d', false),
          const SizedBox(height: 12),
          buildDateSection('6 December 2026'),
          buildExpenseRow('Eating', 'Budget: 300.000d', '100.000d', true),
          buildExpenseRow('Friends', 'Budget: 300.000d', '100.000d', false),
        ],
      ),
    );
  }

  Widget buildDateSection(String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: titleText,
        ),
        const SizedBox(height: 12),
        Container(
          height: 2,
          color: const Color(0xFFD9D9D9),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget buildExpenseRow(
      String title, String budget, String price, bool isRed) {
    return Row(
      children: [
        SvgPicture.asset('lib/assets/icon/home_icon/girl_icon.svg'),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titleicon),
            Text(budget, style: titleicon2),
          ],
        ),
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
