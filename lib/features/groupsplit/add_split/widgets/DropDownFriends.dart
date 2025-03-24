import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {

  const CustomDropdown({
    required this.selectedValue, required this.options, required this.hintText, required this.onChanged, super.key,
  });
  final String? selectedValue;
  final List<String> options;
  final String hintText;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButtonFormField<String>(
          value: selectedValue,
          alignment: Alignment.centerLeft, // Đảm bảo dropdown không bị đẩy lên
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12),
          items: options.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
