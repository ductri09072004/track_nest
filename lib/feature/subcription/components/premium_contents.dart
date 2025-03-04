import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PremiumPlanWidget extends StatelessWidget {
  const PremiumPlanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Premium',
          style: TextStyle(fontSize: 20, fontFamily: 'Lato'),
        ),
        const SizedBox(height: 10),
        _buildFeatureRow('Including all free features'),
        _buildFeatureRow('Use OpenAI to scan, limit 15 scan/day'),
        _buildFeatureRow('Login and restore data through mail'),
        _buildFeatureRow('No advertisements'),
        _buildFeatureRow('Max 20 friends/group and 20 groups'),
        _buildFeatureRow('Add max 20 categories'),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), // Bo góc
            border: Border.all(),
          ),
          child: Column(
            children: [
              _buildPriceRow(), // Hiển thị phần giá
              const SizedBox(height: 10),
              _buildCurrentPlan(), // Hiển thị "Your current plan"
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow() {
    return const Row(
      children: [
        Text(
          '29.000 ',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          'VND/month',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato_Regular',
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SvgPicture.asset('lib/assets/icon/components_icon/tick_icon.svg'),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontFamily: 'Lato_Regular'),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentPlan() {
    return Align(
      alignment: Alignment.centerLeft, // Căn sát lề trái
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF013CBC), // Màu nền
          borderRadius: BorderRadius.circular(12), // Bo góc
        ),
        child: const Text(
          'Update to premium',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
