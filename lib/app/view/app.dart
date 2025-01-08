import 'package:flutter/material.dart';
import 'package:testverygood/feature/history_main.dart';
import 'package:testverygood/feature/home_main.dart';
import 'package:testverygood/feature/statistical_main.dart';
import 'package:testverygood/feature/setting_main.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Danh sách các trang con, thêm trang "Thống kê"
  final List<Widget> _pages = [
    const HomePage(),
    const StatisticalPage(),
    const HomePage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('lib/assets/icon/home_icon.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('lib/assets/icon/statistical_icon.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('lib/assets/icon/his_icon.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('lib/assets/icon/setting_icon.svg'),
            label: '',
          ),
        ],
      ),
    );
  }
}
