import 'package:flutter/material.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/features/main_navbar.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  void _confirmPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HeaderA(title: 'Payment'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 40.0), // ✅ Thêm padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa nội dung
          children: [
            const SizedBox(height: 20), // ✅ Thêm khoảng cách
            const Icon(Icons.check_circle, color: Colors.green, size: 120),
            const SizedBox(height: 36),
            const Text(
              'Transaction results will be confirmed within 30 minutes',
              style: TextStyle(
                  fontSize: 24, fontFamily: 'Lato', color: Color(0xFF4BB543)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Thank you for purchasing the premium package, please experience our best services',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato-Regular',
                  color: Color(0xFF808080),),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Button(
              label: 'Go to home',
              onPressed: () => _confirmPayment(context),
            ),
          ],
        ),
      ),
    );
  }
}
