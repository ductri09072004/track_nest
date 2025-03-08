import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:testverygood/features/add/app.dart';
import 'package:testverygood/features/groupsplit/history/app.dart';
import 'package:testverygood/features/home/app.dart';
import 'package:testverygood/features/settings/setting/app.dart';
import 'package:testverygood/features/statistical/app.dart';
import 'package:testverygood/features/transaction/scanbill/view/scanphoto.dart';

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
    const ImagePickerScreen(),
    const HistoryPage(),
    const SettingPage(),
  ];

  final List<String> _selectedIcons = [
    'lib/assets/icon/active_navbar/homeA_icon.svg',
    'lib/assets/icon/active_navbar/statisA_icon.svg',
    'lib/assets/icon/active_navbar/addA_icon.svg',
    'lib/assets/icon/active_navbar/hisA_icon.svg',
    'lib/assets/icon/active_navbar/settingA_icon.svg',
  ];

  final List<String> _defaultIcons = [
    'lib/assets/icon/inactive_navbar/home_icon.svg',
    'lib/assets/icon/inactive_navbar/statistical_icon.svg',
    'lib/assets/icon/active_navbar/addA_icon.svg',
    'lib/assets/icon/inactive_navbar/his_icon.svg',
    'lib/assets/icon/inactive_navbar/setting_icon.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Đảm bảo màu nền hiển thị đúng
        backgroundColor: Colors.white, // Màu nền navbar
        showSelectedLabels: false, // Ẩn label khi icon được chọn
        showUnselectedLabels: false, // Ẩn label khi icon chưa được chọn
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 0 ? _selectedIcons[0] : _defaultIcons[0],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 1 ? _selectedIcons[1] : _defaultIcons[1],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 2 ? _selectedIcons[2] : _defaultIcons[2],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 3 ? _selectedIcons[3] : _defaultIcons[3],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 4 ? _selectedIcons[4] : _defaultIcons[4],
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
