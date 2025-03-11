import 'package:flutter/material.dart';
import 'package:testverygood/assets/core/appcolor.dart';

class Dropdown extends StatelessWidget {
  // Hàm callback khi thay đổi giá trị

  const Dropdown({
    required this.selectedValue,
    required this.options,
    required this.hintText,
    required this.onChanged,
    super.key,
  });
  final String? selectedValue; // Giá trị hiện tại
  final List<String> options; // Danh sách các tùy chọn
  final String hintText; // Gợi ý hiển thị khi chưa chọn
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // Bo góc của Dropdown
        border: Border.all(
          color: AppColor.whiteDarker,
        ),
      ),
      child: DropdownButton<String>(
        value: selectedValue, // Giá trị hiện tại
        hint: Text(
          hintText,
          style: const TextStyle(
            color: AppColor.whiteDark,
            
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
