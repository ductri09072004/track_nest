import 'package:flutter/material.dart';

class ButtonAdd extends StatelessWidget { // Thêm biến để chỉnh màu viền

  const ButtonAdd({
    required this.text,
    required this.onPressed,
    super.key,
    this.borderColor = Colors.black, // Mặc định là màu đen nếu không truyền vào
  });
  final String text;
  final VoidCallback onPressed;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              backgroundColor: Colors.white,
            ),
            onPressed: onPressed,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
