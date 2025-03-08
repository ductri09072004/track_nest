import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingPage extends StatelessWidget {
  final String iconPath; // Biến đường dẫn SVG

  const LoadingPage({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  Color(0xFF013CBC),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
