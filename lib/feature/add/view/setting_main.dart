import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Trang add',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
