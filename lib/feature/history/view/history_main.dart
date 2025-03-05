import 'package:flutter/material.dart';
import 'package:testverygood/components/component_app/Header_main.dart';
import 'package:testverygood/feature/history/view/body.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          HeaderMain(
            title: 'History',
          ),
          BodyMain(),
        ],
      ),
    );
  }
}
