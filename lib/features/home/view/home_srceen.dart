import 'package:flutter/material.dart';
import 'package:testverygood/components/Header_main.dart';
import 'package:testverygood/components/load_page.dart';
import 'package:testverygood/features/home/view/body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  bool _isMounted = false; // Biến kiểm tra widget có còn tồn tại không

  @override
  void initState() {
    super.initState();
    _isMounted = true;

    // Giả lập thời gian load dữ liệu
    Future.delayed(const Duration(seconds: 1), () {
      if (_isMounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _isMounted = false; // Đánh dấu widget đã bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Column(
            children: [
              HeaderMain(title: 'My Transactions'),
              Expanded(child: BodyMain()), // Nội dung chính
            ],
          ),
          if (_isLoading)
            const Positioned.fill(
              child: LoadingPage(
                iconPath: 'lib/assets/icon/active_navbar/homeA_icon.svg',
              ),
            ),
        ],
      ),
    );
  }
}
