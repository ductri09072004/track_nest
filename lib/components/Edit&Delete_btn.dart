import 'package:flutter/material.dart';
import 'package:testverygood/assets/core/appcolor.dart';

class EditDeleteButtons extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EditDeleteButtons({
    required this.onEdit,
    required this.onDelete,
    Key? key,
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
                color: AppColor.blue,
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
                color: AppColor.blue,
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
                color: AppColor.blue,
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
                color: AppColor.blue,
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
