import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testverygood/bootstrap.dart';
import 'package:testverygood/features/settings/subcription/view/payment.dart';

class PremiumPlanWidget extends StatelessWidget {
  const PremiumPlanWidget({super.key});

  Future<String?> loadTypeId() async {
    return storage.read(key: 'type_id');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Premium',
          style:
              TextStyle(fontSize: 20, fontFamily: 'Lato', color: Colors.green),
        ),
        const SizedBox(height: 10),
        _buildFeatureRow('Including all free features'),
        _buildFeatureRow('Use OpenAI GPT-4 to scan'),
        _buildFeatureRow('Login and restore data through mail'),
        _buildFeatureRow('No advertisements'),
        _buildFeatureRow('Can custom categories'),
        _buildFeatureRow('Priority customer support'),
        _buildFeatureRow('Money-back guarantee'),
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
              FutureBuilder<String?>(
                future: loadTypeId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Hiển thị loading khi chưa có dữ liệu
                  }
                  String? typeId = snapshot.data;
                  return (typeId == 'free')
                      ? _buildCurrentPlanPro(context)
                      : _buildCurrentPlanfree();
                },
              ),
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

  Widget _buildCurrentPlanPro(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          // Điều hướng đến trang mới khi bấm vào nút
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VNPayQRScreen(),
            ),
          );
        },
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
      ),
    );
  }

  Widget _buildCurrentPlanfree() {
    return Align(
      alignment: Alignment.centerLeft, // Căn sát lề trái
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFDBDBDB), // Màu nền
          borderRadius: BorderRadius.circular(12), // Bo góc
        ),
        child: const Text(
          'Your current plan',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Lato',
            color: Color(0xFF727272),
          ),
        ),
      ),
    );
  }
}
