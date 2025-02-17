import 'package:flutter/material.dart';
import 'package:testverygood/feature/home/components/trans_content.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: TransContent(),
      ),
    );
  }
}
