import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isNumeric = false,
    this.keyboardType = TextInputType.text,
    this.maxLength = 20,
    this.isSmallText = false,
    this.onChanged,
  });
  final String hintText;
  final TextEditingController controller;
  final bool isNumeric;
  final TextInputType keyboardType;
  final int maxLength;
  final bool isSmallText;
  final Function(String)? onChanged;

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
    final numericString = _removeThousandsSeparator(value);
    final newValue = int.tryParse(numericString) ?? 0;

    setState(() {
      rawValue = newValue; // Cập nhật giá trị thực
    });

    // Định dạng số có dấu chấm
    final formattedValue = _formatNumber(numericString);

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
    final inputStyle = widget.isSmallText ? txtsmall : txt;

    return Container(
      padding: EdgeInsets.zero,
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
  const InputClassic({
    required this.hintText,
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.hasBorder = true,
    this.hasPadding = true,
    this.focusNode, // Thêm focusNode
  });

  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool hasBorder;
  final bool hasPadding;
  final FocusNode? focusNode; // FocusNode mới

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      focusNode: focusNode, // Gán focusNode vào đây
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFCFCFCF)),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: hasPadding
            ? const EdgeInsets.symmetric(vertical: 12, horizontal: 16)
            : EdgeInsets.zero,
        border: hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              )
            : InputBorder.none,
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

class InputVerify extends StatelessWidget {
  const InputVerify({
    required this.hintText,
    super.key,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.hasBorder = true,
    this.hasPadding = true,
    this.focusNode,
    this.suffixText,
    this.onSuffixPressed,
  });

  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool hasBorder;
  final bool hasPadding;
  final FocusNode? focusNode;
  final String? suffixText;
  final VoidCallback? onSuffixPressed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFCFCFCF)),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: hasPadding
            ? const EdgeInsets.symmetric(vertical: 12, horizontal: 16)
            : EdgeInsets.zero,
        border: hasBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                ),
              )
            : InputBorder.none,
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
        suffix: suffixText != null
            ? GestureDetector(
                onTap: onSuffixPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    suffixText!,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class InputWithClearIcon extends StatefulWidget {
  const InputWithClearIcon({
    required this.hintText,
    required this.controller,
    super.key,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  @override
  _InputWithClearIconState createState() => _InputWithClearIconState();
}

class _InputWithClearIconState extends State<InputWithClearIcon> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    setState(() {});
    if (widget.onChanged != null) {
      widget.onChanged!(widget.controller.text);
    }
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
        fillColor: Colors.transparent,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFCFCFCF),
            width: 1.5,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        suffixIcon: widget.controller.text.isNotEmpty
            ? IconButton(
                icon: SvgPicture.asset(
                  'lib/assets/icon/components_icon/cancel.svg',
                ),
                onPressed: () {
                  widget.controller.clear();
                  setState(() {});
                  if (widget.onChanged != null) {
                    widget.onChanged!('');
                  }
                },
              )
            : null,
      ),
    );
  }
}
