import 'package:flutter/material.dart';
import 'package:testverygood/components/Header_main.dart';
import 'package:testverygood/feature/statistical/view/body.dart';
import 'package:testverygood/feature/statistical/components/barchart.dart';

class StatisticalPage extends StatelessWidget {
  const StatisticalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          HeaderMain(showBalance: false),
          BodyMain(),
          Barchart(),
        ],
      ),
    );
  }
}
