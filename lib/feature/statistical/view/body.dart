import 'package:flutter/material.dart';
import 'package:testverygood/feature/statistical/components/content.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 3,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 2.5 / 3,
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 100), // Padding góc trên là 30
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Content(),
            ],
          ),
        ),
      ),
    );
  }
}
