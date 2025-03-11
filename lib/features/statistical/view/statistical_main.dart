import 'package:flutter/material.dart';
import 'package:testverygood/components/Header_main.dart';
import 'package:testverygood/components/load_page.dart';
import 'package:testverygood/features/statistical/view/body.dart';

class StatisticalPage extends StatefulWidget {
  const StatisticalPage({super.key});

  @override
  _StatisticalPageState createState() => _StatisticalPageState();
}

class _StatisticalPageState extends State<StatisticalPage> {
  bool _isLoading = true;
  bool _isMounted = false; // Kiểm tra xem trang còn tồn tại không

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
    _isMounted = false; // Đánh dấu trang đã bị huỷ
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Nội dung chính (hiển thị luôn)
          const Column(
            children: [
              HeaderMain(title: 'Statistical'),
              BodyMain(),
            ],
          ),
          // LoadingPage (hiển thị mờ dần khi load xong)
          if (_isLoading)
            AnimatedOpacity(
              opacity: _isLoading ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: const Positioned.fill(
                child: LoadingPage(
                  iconPath: 'lib/assets/icon/active_navbar/statisA_icon.svg',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
