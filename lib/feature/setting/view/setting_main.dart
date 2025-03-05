import 'package:flutter/material.dart';
import 'package:testverygood/components/component_app/Header_main.dart';
import 'package:testverygood/feature/setting/view/body.dart';

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
