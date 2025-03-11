import 'package:flutter/material.dart';
import 'package:testverygood/components/Header_main.dart';
import 'package:testverygood/components/load_page.dart';
import 'package:testverygood/features/groupsplit/history/view/body.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
              HeaderMain(title: 'History'),
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
                  iconPath: 'lib/assets/icon/active_navbar/hisA_icon.svg',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
