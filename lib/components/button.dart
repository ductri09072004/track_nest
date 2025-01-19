import 'package:flutter/material.dart';

class ToggleSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const ToggleSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

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
          color: value ? const Color(0xFF65558F) : Colors.grey,
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
  final String label;
  final VoidCallback onPressed;

  const Button({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF791CAC),
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
    );
  }
}
