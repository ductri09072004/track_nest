import 'package:flutter/material.dart';
import 'package:testverygood/feature/history/components/content.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 5.5,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 2.5 / 3,
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Content(),
          ],
        ),
      ),
    );
  }
}
