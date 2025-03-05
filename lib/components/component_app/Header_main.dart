import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/components/component_app/date.dart'; // Import HorizontalList từ đây

class HeaderMain extends StatelessWidget {
  final String title;
  final bool showSearchAndCalendar; // Biến để ẩn/hiện search và calendar
  final bool showHorizontalList; // Biến để ẩn/hiện HorizontalList

  const HeaderMain({
    super.key,
    required this.title,
    this.showSearchAndCalendar = true, // Mặc định hiển thị
    this.showHorizontalList = true, // Mặc định hiển thị
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 55,
        left: 20,
        right: 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFCFCFCF),
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
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('chọn ngày!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
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
                  child: SvgPicture.asset(
                    'lib/assets/icon/home_icon/search_icon.svg',
                  ),
                ),
              ],
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
    color: Colors.black,
    fontSize: 18,
    fontFamily: 'Lato',
  );
}
