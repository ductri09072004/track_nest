import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDateSection('15.93%', 'Eating', '1 transaction', '70.000đ'),
              const SizedBox(height: 12),
              buildDateSection('15.93%', 'Eating', '1 transaction', '70.000đ'),
              const SizedBox(height: 12),
              buildDateSection('15.93%', 'Eating', '1 transaction', '70.000đ'),
              const SizedBox(height: 12),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDateSection(
      String percent, String title, String tranc, String price) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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

            const SizedBox(
              width: 10,
            ), // Thêm khoảng cách giữa phần trăm và title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: titleText,
                ),
                Text(
                  tranc,
                  style: titleicon2, // Đặt style khác cho thông tin giao dịch
                ),
              ],
            ),
            const Spacer(),
            Text(
              price,
              style: titleprice,
            ),
          ],
        ),
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
  static const TextStyle titleicon = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
  );
  static const TextStyle titleicon2 = TextStyle(
    fontSize: 12,
    fontFamily: 'Lato_Light',
  );
  static const TextStyle titleprice = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
  static const TextStyle titleprice2 = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: Color(0xFF5CB338),
  );
}
