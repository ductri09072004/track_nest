import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/feature/add/app.dart';
import 'package:testverygood/feature/history/app.dart';
import 'package:testverygood/feature/home/app.dart';
import 'package:testverygood/feature/statistical/app.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Danh sách các trang con
  final List<Widget> _pages = [
    const HomePage(),
    const StatisticalPage(),
    const HistoryPage(),
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
