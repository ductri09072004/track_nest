import 'package:flutter/material.dart';
import 'package:testverygood/components/categories.dart';
import 'package:testverygood/components/selectMonth.dart'; // Import month picker

void showSearchDialog(BuildContext context) {
  DateTime now = DateTime.now();
  final selectedStartDate =
      ValueNotifier<DateTime>(now); // Tháng bắt đầu
  final selectedEndDate =
      ValueNotifier<DateTime>(now); // Tháng kết thúc
  final selectedCategory =
      ValueNotifier<String>(''); // Danh mục

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Advanced Search'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Chọn Category
            const Text('Select Category:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            CategoriesText(
              onCategorySelected: (String category) {
                selectedCategory.value = category;
              },
            ),
            const SizedBox(height: 16),

            // Chọn tháng bắt đầu
            const Text('Select Start Month:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ValueListenableBuilder<DateTime>(
              valueListenable: selectedStartDate,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: () {
                    showMonthPickerDialog(context, selectedStartDate);
                  },
                  child: Text('${_getMonthName(value.month)} ${value.year}'),
                );
              },
            ),

            const SizedBox(height: 16),

            // Chọn tháng kết thúc
            const Text('Select End Month:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ValueListenableBuilder<DateTime>(
              valueListenable: selectedEndDate,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: () {
                    showMonthPickerDialog(context, selectedEndDate);
                  },
                  child: Text('${_getMonthName(value.month)} ${value.year}'),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Xử lý dữ liệu trước khi đóng
              print('Category: ${selectedCategory.value}');
              print(
                  'Start Month: ${selectedStartDate.value.month} ${selectedStartDate.value.year}');
              print(
                  'End Month: ${selectedEndDate.value.month} ${selectedEndDate.value.year}');
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: const Text('Apply'),
          ),
        ],
      );
    },
  );
}

/// Convert month number to name
String _getMonthName(int month) {
  const List<String> monthNames = [
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
