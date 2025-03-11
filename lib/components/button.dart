import 'package:flutter/material.dart';
import 'package:testverygood/assets/core/appcolor.dart';

class ToggleSwitch extends StatelessWidget {
  const ToggleSwitch({
    required this.value,
    required this.onChanged,
    super.key,
  });
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value), // Thay đổi trạng thái khi nhấn
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 52,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: value ? AppColor.blue : AppColor.blackLighter, // Màu nền
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(12), // Nút gạt hình tròn
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Chiếm toàn bộ chiều rộng
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.blue,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24), // Bo góc của nút
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Lato',
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Chiếm toàn bộ chiều ngang
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              vertical: 12), // Điều chỉnh padding dọc
          side:
              const BorderSide(color: AppColor.blue, width: 2), // Viền màu
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Bo góc của nút
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Lato',
            color: AppColor.blue, // Màu chữ trùng màu viền
          ),
        ),
      ),
    );
  }
}
