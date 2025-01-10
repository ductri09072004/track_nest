import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/welcome/Welcome1_page.dart';

class PlashPages extends StatelessWidget {
  const PlashPages({super.key});

  @override
  Widget build(BuildContext context) {
    // Giả sử có một thời gian chờ cho Splash
    Future.delayed(const Duration(seconds: 3), () {
      // Sau khi splash hoàn tất, chuyển đến MainPage
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(builder: (context) => const Welcome1Page()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/assets/icon/logo_app.svg',
            ),
            const SizedBox(height: 20),
            const Text(
              'Track Nest',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
