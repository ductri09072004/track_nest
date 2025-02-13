import 'package:flutter/material.dart';
import 'package:testverygood/components/Header_main.dart';
import 'package:testverygood/feature/setting/view/body.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          HeaderMain(
            showIcons: false,
            showHorizontalList: false,
            showBalance: false,
          ),
          BodyMain(),
        ],
      ),
    );
  }
}
