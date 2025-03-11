import 'package:flutter/material.dart';
import 'package:testverygood/features/groupsplit/history/view/widgets/content.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD),
        ),
        child: const SingleChildScrollView(
          child: Content(),
        ),
      ),
    );
  }
}
