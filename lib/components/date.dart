import 'package:flutter/material.dart';

class HorizontalList extends StatefulWidget {
  const HorizontalList({super.key});

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  // Khởi tạo items là một danh sách rỗng trước, và sẽ được cập nhật trong initState
  List<String> items = [];
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    _generateMonthsList();
    _setSelectedItem();
  }

  // Hàm tạo danh sách các tháng từ thời điểm hiện tại
  void _generateMonthsList() {
    var currentDate = DateTime.now();
    items = List.generate(12, (index) {
      var monthDate = DateTime(currentDate.year, currentDate.month + index);
      var monthName = _getMonthName(monthDate.month);
      return '$monthName ${monthDate.year}';
    });
  }

  // Hàm để lấy tên tháng từ số tháng
  String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month - 1];
  }

  // Hàm để đặt mặc định tháng hiện tại là mục được chọn
  void _setSelectedItem() {
    var currentDate = DateTime.now();
    var currentMonthYear =
        '${_getMonthName(currentDate.month)} ${currentDate.year}';

    // Kiểm tra xem tháng hiện tại có trong danh sách items không
    if (items.contains(currentMonthYear)) {
      selectedItem = currentMonthYear;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map((item) {
            final isSelected = item == selectedItem;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedItem = item;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                ), // Khoảng cách giữa các phần tử
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color:
                      isSelected ? const Color(0xFF8B3BB7) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    item,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
