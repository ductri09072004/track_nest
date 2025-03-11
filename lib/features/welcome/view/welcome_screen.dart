import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:testverygood/assets/core/appcolor.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/features/main_navbar.dart';
import 'package:testverygood/features/welcome/widgets/page1.dart';
import 'package:testverygood/features/welcome/widgets/page2.dart';

class WelcomeSlider extends StatefulWidget {
  const WelcomeSlider({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeSliderState createState() => _WelcomeSliderState();
}

class _WelcomeSliderState extends State<WelcomeSlider> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              children: const [
                WPage1(),
                WPage2(),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: 2,
            effect: const WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: AppColor.blue,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Button(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          },
          label: 'Get Started',
        ),
      ),
    );
  }

  static const TextStyle txtbtn = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Lato',
  );
}
