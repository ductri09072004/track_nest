import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/feature/welcome/app.dart';

class PlashPages extends StatelessWidget {
  const PlashPages({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Chia không gian giữa các phần tử
        children: [
          // Khoảng trống phía trên
          const Spacer(),
          // Logo ở giữa màn hình
          Center(
            child: SvgPicture.asset(
              'lib/assets/icon/logo_app.svg',
            ),
          ),
          const SizedBox(height: 20),
          // Khoảng trống giữa logo và chữ
          const Spacer(),
          // Chữ nằm ở dưới cùng màn hình
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Text(
                  'Track Nest',
                  style: nameapp,
                ),
                Text(
                  'Nesting your savings for the future',
                  style: txtapp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle nameapp = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle txtapp = TextStyle(
    fontSize: 16,
  );
}
