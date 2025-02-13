import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  final String? selectedValue; // Giá trị hiện tại
  final List<String> options; // Danh sách các tùy chọn
  final String hintText; // Gợi ý hiển thị khi chưa chọn
  final ValueChanged<String?> onChanged; // Hàm callback khi thay đổi giá trị

  const Dropdown({
    Key? key,
    required this.selectedValue,
    required this.options,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // Bo góc của Dropdown
        border: Border.all(
          color: const Color(0xFFA7A7A7), // Màu viền
        ),
      ),
      child: DropdownButton<String>(
        value: selectedValue, // Giá trị hiện tại
        hint: Text(
          hintText,
          style: const TextStyle(
            color: Color(0xFFCFCFCF),
            fontSize: 14,
            fontFamily: 'Lato_Regular',
          ),
        ),
        isExpanded: true, // Dropdown chiếm toàn bộ chiều ngang
        underline: Container(), // Loại bỏ gạch chân mặc định
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), // Bo góc cho mục
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(option),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged, // Callback khi chọn
      ),
    );
  }
}
