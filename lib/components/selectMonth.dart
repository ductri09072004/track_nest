import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

void showMonthPickerDialog(
    BuildContext context, ValueNotifier<DateTime> selectedDate,) {
  showMonthPicker(
    context: context,
    initialDate: selectedDate.value,
    firstDate: DateTime(DateTime.now().year - 10),
    lastDate: DateTime(DateTime.now().year + 10),
  ).then((date) {
    if (date != null) {
      selectedDate.value = date; // Update selected month
    }
  });
}
