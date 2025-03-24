import 'package:flutter/material.dart';

class GroupSelectionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GroupSelectionButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF013CBC), // Màu chữ
        side: const BorderSide(color: Color(0xFF013CBC)), // Viền xanh
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bo góc
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ), // Kích thước
      ),
      child: const Text(
        'Add group',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}
