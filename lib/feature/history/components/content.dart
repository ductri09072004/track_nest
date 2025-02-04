import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<Map<String, dynamic>> details = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Hàm tải dữ liệu từ SharedPreferences
  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? detailsJson = prefs.getString('details');

    if (detailsJson != null) {
      setState(() {
        List<Map<String, dynamic>> loadedDetails =
            List<Map<String, dynamic>>.from(
                (jsonDecode(detailsJson) as List<dynamic>)
                    .map((item) => Map<String, dynamic>.from(item)));

        // Thêm dữ liệu mới vào danh sách cũ
        details.addAll(loadedDetails);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          // Hiển thị dữ liệu đã lưu nếu có
          if (details.isNotEmpty)
            ..._buildGroupedDetails(), // Hiển thị theo nhóm
          if (details.isEmpty) const Text('No data available'),
        ],
      ),
    );
  }

  // Hàm nhóm các mục chi tiêu theo ngày
  List<Widget> _buildGroupedDetails() {
    Map<String, List<Map<String, dynamic>>> groupedDetails = {};

    // Nhóm các dữ liệu theo ngày
    for (var detail in details) {
      String date = detail['date'] ??
          'Unknown Date'; // Giả sử mỗi detail có trường 'date'
      if (!groupedDetails.containsKey(date)) {
        groupedDetails[date] = [];
      }
      groupedDetails[date]?.add(detail);
    }

    // Trả về danh sách các phần hiển thị theo từng nhóm
    List<Widget> groupedWidgets = [];
    groupedDetails.forEach((date, detailsList) {
      // Xây dựng phần hiển thị cho mỗi nhóm
      groupedWidgets
          .add(buildDateSection('Eating', date)); // Sử dụng ngày làm tham số

      // Thêm các mục chi tiêu cho nhóm này
      for (var detail in detailsList) {
        groupedWidgets
            .add(buildExpenseRow(detail['name'], detail['amount'], true));
      }

      // Thêm khoảng cách giữa các nhóm
      groupedWidgets
          .add(const SizedBox(height: 20)); // Khoảng cách giữa các nhóm
    });

    return groupedWidgets;
  }

  Widget buildDateSection(String title, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset('lib/assets/icon/home_icon/girl_icon.svg'),
            Text(
              title,
              style: titleText,
            ),
            const Spacer(),
            Text(
              date,
              style: titleText,
            ),
          ],
        ),
        Container(
          height: 2,
          color: const Color(0xFF000000),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget buildExpenseRow(String title, String price, bool isRed) {
    return Row(
      children: [
        Text(title, style: titleicon),
        const Spacer(),
        Text(
          price,
          style: isRed ? titleprice : titleprice2,
        ),
      ],
    );
  }

  static const TextStyle titleText = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
  static const TextStyle titleicon = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
  );
  static const TextStyle titleicon2 = TextStyle(
    fontSize: 12,
    fontFamily: 'Lato_Light',
  );
  static const TextStyle titleprice = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: Color(0xFFF44336),
  );
  static const TextStyle titleprice2 = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: Color(0xFF5CB338),
  );
}
