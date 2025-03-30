import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

void showMonthPickerDialog(
  BuildContext context,
  ValueNotifier<DateTime> selectedDate,
) {
  showMonthPicker(
    context: context,
    initialDate: selectedDate.value,
    firstDate: DateTime(DateTime.now().year),
    lastDate: DateTime(DateTime.now().year + 1),
    // locale: const Locale("en"),
    selectableMonthPredicate: (month) {
      // Chỉ cho phép chọn các tháng từ hiện tại trở về sau
      return month.isAfter(DateTime.now().subtract(const Duration(days: 30)));
    },
  ).then((date) {
    if (date != null) {
      selectedDate.value = date; // Cập nhật tháng được chọn
    }
  });
}
