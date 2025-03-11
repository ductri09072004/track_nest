import 'package:flutter/material.dart';
import 'package:testverygood/features/groupsplit/history/widgets/content.dart';
import 'package:testverygood/assets/core/appcolor.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 5,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 12, bottom: 110),
        decoration: const BoxDecoration(
          color: AppColor.white,
        ),
        child: const SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 140),
          child: Content(),
        ),
      ),
    );
  }
}
