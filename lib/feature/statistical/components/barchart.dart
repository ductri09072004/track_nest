import 'package:flutter/material.dart';
import 'package:testverygood/feature/statistical/components/content.dart';

class Barchart extends StatelessWidget {
  const Barchart({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 147,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(20), // Thêm margin 20 cho Container
        height: 222,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.1), // Màu bóng
              spreadRadius: 3, // Khoảng cách bóng
              blurRadius: 10, // Độ mờ của bóng
              offset: const Offset(0, 4), // Vị trí bóng (đổ xuống dưới)
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello'),
            ],
          ),
        ),
      ),
    );
  }
}
