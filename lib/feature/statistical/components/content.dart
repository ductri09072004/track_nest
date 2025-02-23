import 'package:flutter/material.dart';

class ExpenseData {
  ExpenseData({
    required this.percent,
    required this.title,
    required this.price,
  });
  final String percent;
  final String title;
  final String price;
}

class Content extends StatelessWidget {
  const Content({super.key, required this.data});
  final List<ExpenseData> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data
            .map(
              (expense) => Column(
                children: [
                  buildDateSection(
                    expense.percent,
                    expense.title,
                    expense.price,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildDateSection(
    String percent,
    String title,
    String price,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF537FF1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            percent,
            style: perText,
          ),
        ),
        const SizedBox(width: 10), // Khoảng cách giữa phần trăm và title
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titleText),
          ],
        ),
        const Spacer(),
        Text(price, style: titleprice),
      ],
    );
  }

  static const TextStyle titleText = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
  static const TextStyle perText = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: Color(0xFFFFFFFF),
  );
  static const TextStyle titleicon2 = TextStyle(
    fontSize: 12,
    fontFamily: 'Lato_Light',
  );
  static const TextStyle titleprice = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
}
