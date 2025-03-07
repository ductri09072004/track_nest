import 'package:flutter/material.dart';
import 'package:testverygood/features/home/view/widgets/balance_cart.dart';
import 'package:testverygood/features/home/view/widgets/trans_content.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD),
        ),
        child: const SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Căn trái tất cả phần tử
            children: [
              BalanceCard(),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 20), // Căn lề trái theo ý muốn
                child: Text(
                  'Transactions',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              ExpContent(),
            ],
          ),
        ),
      ),
    );
  }
}
