import 'package:flutter/material.dart';

class EditDeleteButtons extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EditDeleteButtons({
    Key? key,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onEdit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // Nền trong suốt
              side: const BorderSide(
                color: Color(0xFF791CAC),
                width: 2,
              ), // Viền màu tím
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Bo góc 10px
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              elevation: 0,
            ),
            child: const Text(
              'Edit',
              style: TextStyle(
                color: Color(0xFF791CAC),
                fontSize: 20,
                fontFamily: 'lato',
              ),
            ),
          ),
        ),
        const SizedBox(width: 10), // Khoảng cách giữa 2 nút
        Expanded(
          child: ElevatedButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent, // Nền trong suốt
              side: const BorderSide(
                color: Color(0xFF791CAC),
                width: 2,
              ), // Viền màu đỏ cho nút Delete
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Bo góc 10px
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              elevation: 0,
            ),
            child: const Text(
              'Delete',
              style: TextStyle(
                color: Color(0xFF791CAC),
                fontSize: 20,
                fontFamily: 'lato',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
