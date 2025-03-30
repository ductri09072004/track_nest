import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/components/date.dart'; // Import HorizontalList từ đây
import 'package:testverygood/assets/core/appcolor.dart';
import 'package:testverygood/components/selectMonth.dart';
import 'package:testverygood/components/search.dart';

class HeaderMain extends StatelessWidget {
  final String title;
  final bool showSearchAndCalendar; // Biến để ẩn/hiện search và calendar
  final bool showHorizontalList; // Biến để ẩn/hiện HorizontalList
  final String? type;
  final bool showtypeACC;

  const HeaderMain({
    super.key,
    required this.title,
    this.type,
    this.showSearchAndCalendar = true, // Mặc định hiển thị
    this.showHorizontalList = true, // Mặc định hiển thị
    this.showtypeACC = false,
  });

  @override
  Widget build(BuildContext context) {
    final selectedMonth = ValueNotifier<DateTime>(DateTime.now());
    return Container(
      padding: const EdgeInsets.only(
        top: 55,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColor.whiteDark,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Thu gọn chiều cao theo nội dung
        children: [
          Row(
            children: [
              Text(
                title,
                style: texttop,
              ),
              const Spacer(),
              if (showSearchAndCalendar) ...[
                GestureDetector(
                  onTap: () => showMonthPickerDialog(
                    context,
                    selectedMonth,
                  ), // Gọi từ selectMonth.dart
                  child: SvgPicture.asset(
                    'lib/assets/icon/home_icon/calendar_icon.svg',
                  ),
                ),
                const SizedBox(width: 24),
                GestureDetector(
                  onTap: () =>
                      showSearchDialog(context), // Gọi từ filterSearch.dart
                  child: SvgPicture.asset(
                    'lib/assets/icon/home_icon/search_icon.svg',
                  ),
                ),
              ],
              if (showtypeACC) ...[
                Text(
                  '$type',
                  style: (type == 'free') ? texttypefree : texttypepro,
                ),
              ]
            ],
          ),
          const SizedBox(height: 28),
          if (showHorizontalList) ...[
            const HorizontalList(),
          ],
        ],
      ),
    );
  }

  static const TextStyle texttop = TextStyle(
    color: AppColor.black,
    fontSize: 18,
    fontFamily: 'Lato',
  );
  static const TextStyle texttypet = TextStyle(
    color: AppColor.black,
    fontSize: 16,
    fontFamily: 'Lato',
  );
  static const TextStyle texttypepro = TextStyle(
    color: AppColor.green,
    fontSize: 16,
    fontFamily: 'Lato',
  );
  static const TextStyle texttypefree = TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontFamily: 'Lato',
  );
}
