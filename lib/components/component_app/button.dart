import 'package:flutter/material.dart';

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
          color: value ? const Color(0xFF013CBC) : Colors.grey,
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
                color: Colors.white,
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
          backgroundColor: const Color(0xFF013CBC),
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
            color: Colors.white,
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
              const BorderSide(color: Color(0xFF013CBC), width: 2), // Viền màu
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Bo góc của nút
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Lato',
            color: Color(0xFF013CBC), // Màu chữ trùng màu viền
          ),
        ),
      ),
    );
  }
}
