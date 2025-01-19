import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Thêm package intl để format số

class InputField extends StatelessWidget {
  final String hintText; // Gợi ý placeholder
  final TextEditingController controller; // Bộ điều khiển văn bản
  final bool isNumeric; // Xác định chỉ cho phép nhập số
  final TextInputType keyboardType; // Loại bàn phím (số hoặc chữ)
  final int maxLength; // Giới hạn độ dài ký tự (tùy chọn)

  const InputField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isNumeric = false, // Mặc định không giới hạn là số
    this.keyboardType = TextInputType.text, // Mặc định là bàn phím chữ
    this.maxLength = 20, // Giới hạn mặc định 20 ký tự
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : keyboardType,
        inputFormatters: isNumeric
            ? [FilteringTextInputFormatter.digitsOnly] // Chỉ cho phép nhập số
            : [],
        maxLength: maxLength, // Giới hạn độ dài ký tự
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: txt,

          counterText: '', // Loại bỏ bộ đếm ký tự
          border: InputBorder.none, // Không viền
        ),
        style: txt,
        onChanged: (value) {
          if (isNumeric) {
            String newValue = _formatNumber(value);
            if (newValue != value) {
              controller.value = TextEditingValue(
                text: newValue,
                selection: TextSelection.collapsed(offset: newValue.length),
              );
            }
          }
        },
      ),
    );
  }

  // Hàm format số với dấu chấm
  String _formatNumber(String value) {
    if (value.isEmpty) return '';
    final number = int.tryParse(value.replaceAll('.', ''));
    if (number == null) return value;
    return NumberFormat('#,###', 'en_US').format(number).replaceAll(',', '.');
  }

  static const TextStyle txt = TextStyle(
    fontSize: 36, // Kích thước font
    color: Color(0xFF808080),
    fontFamily: 'Lato',
  );
}
