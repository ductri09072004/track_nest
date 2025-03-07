import 'package:flutter/material.dart';
import 'package:testverygood/features/settings/subcription/components/free_contents.dart';
import 'package:testverygood/features/settings/subcription/components/premium_contents.dart';
import 'package:testverygood/features/main_navbar.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/HeaderA.dart';

class UpgradeAccountPage extends StatelessWidget {
  void navigateToTargetPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      // ignore: inference_failure_on_instance_creation
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderA(
        title: '',
      ),
      body: Container(
        color: const Color(0xFFFFFFFF), // Màu nền của body
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  child: Text(
                    'Choose your plan',
                    style: TextStyle(fontSize: 30, fontFamily: 'Lato'),
                  ),
                ),
                const SizedBox(height: 16),
                const FreePlanWidget(),
                const SizedBox(height: 16),
                const PremiumPlanWidget(),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lato',
                          color: Color(0xFFA7A7A7),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Color(0xFFA7A7A7),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                OutlineButton(
                  label: 'Restore Purchase',
                  onPressed: () {
                    navigateToTargetPage(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
