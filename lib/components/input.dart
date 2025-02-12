import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isNumeric;
  final TextInputType keyboardType;
  final int maxLength;
  final bool isSmallText;
  final Function(String)? onChanged;

  const InputField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.isNumeric = false,
    this.keyboardType = TextInputType.text,
    this.maxLength = 20,
    this.isSmallText = false,
    this.onChanged,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  int rawValue = 0; // Lưu giá trị thực không có dấu chấm

  String _removeThousandsSeparator(String value) {
    return value.replaceAll('.', '');
  }

  String _formatNumber(String value) {
    if (value.isEmpty) return '';
    final number = int.tryParse(value);
    if (number == null) return value;
    return NumberFormat('#,###', 'en_US').format(number).replaceAll(',', '.');
  }

  void _handleInputChange(String value) {
    // Xóa dấu phân cách nghìn để lấy giá trị thực
    String numericString = _removeThousandsSeparator(value);
    int newValue = int.tryParse(numericString) ?? 0;

    setState(() {
      rawValue = newValue; // Cập nhật giá trị thực
    });

    // Định dạng số có dấu chấm
    String formattedValue = _formatNumber(numericString);

    // Cập nhật TextField mà không làm mất vị trí con trỏ
    widget.controller.value = TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );

    // Gọi callback nếu có
    if (widget.onChanged != null) {
      widget.onChanged!(numericString);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = widget.isSmallText ? txtsmall : txt;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: widget.controller,
        keyboardType:
            widget.isNumeric ? TextInputType.number : widget.keyboardType,
        inputFormatters: widget.isNumeric
            ? [FilteringTextInputFormatter.digitsOnly] // Chỉ nhập số
            : [],
        maxLength: widget.maxLength,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: inputStyle,
          counterText: '',
          border: InputBorder.none,
        ),
        style: inputStyle,
        onChanged: widget.isNumeric ? _handleInputChange : widget.onChanged,
      ),
    );
  }

  static const TextStyle txt = TextStyle(
    fontSize: 36,
    color: Color(0xFF808080),
    fontFamily: 'Lato',
  );

  static const TextStyle txtsmall = TextStyle(
    fontSize: 16,
    color: Color(0xFF808080),
    fontFamily: 'Lato',
  );
}

class InputClassic extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool hasBorder;
  final bool hasPadding;

  const InputClassic({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.hasBorder = true, // Mặc định có viền
    this.hasPadding = true, // Mặc định có padding
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
        contentPadding: hasPadding
            ? const EdgeInsets.symmetric(vertical: 12, horizontal: 16)
            : EdgeInsets.zero, // Không có padding nếu `hasPadding` là false
        border: hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              )
            : InputBorder.none, // Không có viền nếu `hasBorder` là false
        enabledBorder: hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              )
            : InputBorder.none,
        focusedBorder: hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
              )
            : InputBorder.none,
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
