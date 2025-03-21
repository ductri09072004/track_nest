import 'package:flutter/material.dart';
import 'package:testverygood/features/groupsplit/history/widgets/content.dart';
import 'package:testverygood/assets/core/appcolor.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColor.white,
        ),
        child: const SingleChildScrollView(
          child: Content(),
        ),
      ),
    );
  }
}
