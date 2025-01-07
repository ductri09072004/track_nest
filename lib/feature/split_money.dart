import 'package:flutter/material.dart';

class SplitMoneyPage extends StatelessWidget {
  const SplitMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Trang Chia tiền',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
