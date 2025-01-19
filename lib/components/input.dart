import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart'; // Thêm package intl để format số

class InputField extends StatelessWidget {
  final String hintText; // Gợi ý placeholder
  final TextEditingController controller; // Bộ điều khiển văn bản
  final bool isNumeric; // Xác định chỉ cho phép nhập số
  final TextInputType keyboardType; // Loại bàn phím (số hoặc chữ)
  final int maxLength; // Giới hạn độ dài ký tự (tùy chọn)
  final bool
      isSmallText; // Biến để chọn kiểu chữ nhỏ hay lớn cho hintText và inputText

  const InputField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isNumeric = false, // Mặc định không giới hạn là số
    this.keyboardType = TextInputType.text, // Mặc định là bàn phím chữ
    this.maxLength = 20, // Giới hạn mặc định 20 ký tự
    this.isSmallText = false, // Mặc định là false, dùng kiểu chữ lớn
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Chọn kiểu chữ cho cả hintText và inputText
    final TextStyle inputStyle = isSmallText ? txtsmall : txt;

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
          hintStyle: inputStyle, // Sử dụng style đã chọn cho hintText
          counterText: '', // Loại bỏ bộ đếm ký tự
          border: InputBorder.none, // Không viền
        ),
        style: inputStyle, // Sử dụng style đã chọn cho inputText
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

  static const TextStyle txtsmall = TextStyle(
    fontSize: 16, // Kích thước font nhỏ
    color: Color(0xFF808080),
    fontFamily: 'Lato',
  );
}

class InputClassic extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;

  const InputClassic({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Bo góc
          borderSide: const BorderSide(
            color: Colors.grey, // Màu viền
            width: 1.5, // Độ dày viền
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Bo góc
          borderSide: const BorderSide(
            color: Colors.grey, // Màu viền khi không focus
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Bo góc
          borderSide: const BorderSide(
            color: Colors.blue, // Màu viền khi focus
            width: 2,
          ),
        ),
      ),
    );
  }
}

class InputWithClearIcon extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;

  const InputWithClearIcon({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  _InputWithClearIconState createState() => _InputWithClearIconState();
}

class _InputWithClearIconState extends State<InputWithClearIcon> {
  @override
  void initState() {
    super.initState();
    widget.controller
        .addListener(_updateState); // Lắng nghe sự thay đổi của controller
  }

  @override
  void dispose() {
    widget.controller
        .removeListener(_updateState); // Gỡ lắng nghe khi component bị hủy
    super.dispose();
  }

  void _updateState() {
    setState(() {}); // Cập nhật lại giao diện khi nội dung thay đổi
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.transparent, // Nền trong suốt
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFCFCFCF), // Màu viền bottom
            width: 1.5,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, // Màu viền khi focus
            width: 2,
          ),
        ),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: SvgPicture.asset(
                  'lib/assets/icon/components_icon/cancel.svg', // Đường dẫn icon SVG
                ),
                onPressed: () {
                  widget.controller.clear(); // Xóa text khi nhấn icon
                  setState(() {}); // Cập nhật lại giao diện sau khi xóa
                },
              )
            : null, // Chỉ hiển thị icon khi có nội dung
      ),
    );
  }
}
