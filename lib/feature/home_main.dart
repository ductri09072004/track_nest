import 'package:flutter/material.dart';

class SplitMoneyPage extends StatelessWidget {
  const SplitMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1, // Phần trên
                child: Container(
                  color: const Color.fromARGB(255, 157, 65, 194),
                  alignment: Alignment.center,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              ),
              Expanded(
                flex: 1, // Để khoảng trống bên dưới
                child: Container(
                  color: Colors.transparent,
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
                color: const Color(0xFFFDFDFD),
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
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle texttop = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
}
