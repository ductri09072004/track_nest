import 'package:flutter/material.dart';
import 'package:testverygood/l10n/l10n.dart';
import '../../feature/split_money.dart';
import '../../feature/history.dart';

import '../../feature/statistical.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng chia tiền',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Danh sách các trang con, thêm trang "Thống kê"
  final List<Widget> _pages = [
    const SplitMoneyPage(),
    const HistoryPage(),
    const StatisticalPage(), // Thêm trang Thống kê vào đây
  ];

  // Danh sách tiêu đề cho AppBar, thêm tiêu đề cho trang "Thống kê"
  final List<String> _titles = [
    'Chia Tiền',
    'Lịch Sử',
    'Thống kê', // Thêm tiêu đề cho trang Thống kê
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Chia Tiền',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Lịch Sử',
          ),
          BottomNavigationBarItem(
            // Thêm mục cho trang Thống kê
            icon: Icon(Icons.bar_chart),
            label: 'Thống kê',
          ),
        ],
      ),
    );
  }
}
