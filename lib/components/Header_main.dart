import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/components/date.dart';
import 'package:testverygood/components/filterSearch.dart';
import 'package:testverygood/components/selectMonth.dart';

class HeaderMain extends StatelessWidget {
  final String title; // Thêm tham số tiêu đề

  const HeaderMain({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final selectedMonth = ValueNotifier<DateTime>(DateTime.now());
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFCFCFCF), // Màu viền dưới
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 55,
              left: 20,
              right: 20,
            ),
            child: Row(
              children: [
                Text(
                  title, // Thay thế "Hello" bằng giá trị truyền vào
                  style: texttop,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => showMonthPickerDialog(
                      context, selectedMonth,), // Gọi từ selectMonth.dart
                  child: SvgPicture.asset(
                    'lib/assets/icon/home_icon/calendar_icon.svg',
                  ),
                ),

                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('tìm kiếm'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: GestureDetector(
                      onTap: () =>
                          showSearchDialog(context), // Gọi từ filterSearch.dart
                      child: SvgPicture.asset(
                        'lib/assets/icon/home_icon/search_icon.svg',
                      ),
                    ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const HorizontalList(),
        ],
      ),
    );
  }

  static const TextStyle texttop = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Lato',
  );
}
