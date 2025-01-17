import 'package:flutter/material.dart';
import 'package:testverygood/components/HeaderA.dart';

class SplitPage extends StatelessWidget {
  const SplitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HeaderA(title: 'Split'),
      body: Padding(
        padding: EdgeInsets.all(20), // Thêm padding 24 vào tất cả các cạnh
        child: Column(
          children: [
            Text(
              'Paid by',
              style: txmain,
            ),
          ],
        ),
      ),
    );
  }

  static const TextStyle txmain =
      TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Lato');
}
