import 'package:flutter/material.dart';
import 'package:testverygood/feature/history/components/content.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    // return Positioned(
    //   top: MediaQuery.of(context).size.height / 5,
    //   left: 0,
    //   right: 0,
    //   child: Container(
    //     height: MediaQuery.of(context).size.height,
    //     decoration: const BoxDecoration(
    //       color: Color(0xFFFDFDFD),
    //     ),
    //     child: const Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Content(),
    //       ],
    //     ),
    //   ),
    // );


    return Positioned(
      top: MediaQuery.of(context).size.height / 5,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 12, bottom: 110),
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD),
          // color: Color(0xFFA561CA),
        ),
        // BarChart(),
        child: const Padding(
          padding: EdgeInsets.only(top: 12), // Padding góc trên là 12
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 12, bottom: 110),
            child: Content(),
          ),
        ),
      ),
    );
  }
}
