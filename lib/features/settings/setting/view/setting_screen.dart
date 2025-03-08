import 'package:flutter/material.dart';
import 'package:testverygood/components/Header_main.dart';
import 'package:testverygood/features/settings/setting/view/body.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HeaderMain(
            title: 'Setting',
            showHorizontalList: false,
            showSearchAndCalendar: false,
          ),
          BodyMain(),
        ],
      ),
    );
  }
}
