import 'package:flutter/material.dart';

class StatisticalPage extends StatelessWidget {
  const StatisticalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Trang thống kê',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
