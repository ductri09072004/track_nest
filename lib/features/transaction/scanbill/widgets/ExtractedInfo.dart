import 'package:flutter/material.dart';

class ExtractedInfo extends StatelessWidget {
  final String label;
  final String value;
  final String prefixText;

  const ExtractedInfo({
    Key? key,
    required this.label,
    required this.value,
    this.prefixText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    prefixText.isNotEmpty ? prefixText : '$label: ',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    value.isNotEmpty ? value : 'N/A',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato_Regular',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10), // Tạo khoảng cách giữa các dòng
          const Divider(
              thickness: 1,
              color: Colors.grey), // Thêm gạch ngăn cách (nếu cần)
        ],
      ),
    );
  }
}
