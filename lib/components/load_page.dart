import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/assets/core/appcolor.dart';

class LoadingPage extends StatelessWidget { // Biến đường dẫn SVG

  const LoadingPage({required this.iconPath, super.key});
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Logo (tuỳ chỉnh theo iconPath)
            SvgPicture.asset(
              iconPath,
              width: 80,
              height: 80,
            ),
            const SizedBox(height: 20),
            // Thanh loading
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                minHeight: 6,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColor.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
