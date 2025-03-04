import 'package:flutter/material.dart';

class HorizontalList extends StatefulWidget {
  const HorizontalList({super.key});

  @override
  State<HorizontalList> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  List<String> items = [];
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    _generateMonthsList();
    _setSelectedItem();
  }

  void _generateMonthsList() {
    final currentDate = DateTime.now();
    items = List.generate(12, (index) {
      final monthDate = DateTime(currentDate.year, currentDate.month + index);
      final monthName = _getMonthName(monthDate.month);
      return '$monthName ${monthDate.year}';
    });
  }

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

  void _setSelectedItem() {
    final currentDate = DateTime.now();
    final currentMonthYear =
        '${_getMonthName(currentDate.month)} ${currentDate.year}';

    if (items.contains(currentMonthYear)) {
      selectedItem = currentMonthYear;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Canh lề trên
        children: items.map((item) {
          final isSelected = item == selectedItem;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedItem = item;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Không chiếm hết chiều cao
                children: [
                  Text(
                    item,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 111, // Độ dài của thanh dưới chữ
                      height: 4, // Độ dày của thanh
                      decoration: BoxDecoration(
                        color: const Color(0xFF013CBC),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
