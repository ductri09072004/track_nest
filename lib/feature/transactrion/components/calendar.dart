import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimePickerComponent extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const TimePickerComponent({super.key, required this.onDateSelected});

  @override
  _TimePickerComponentState createState() => _TimePickerComponentState();
}

class _TimePickerComponentState extends State<TimePickerComponent> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked); // Gửi ngày đã chọn lên TransactionMain
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Row(
        children: [
          SvgPicture.asset('lib/assets/icon/transaction_icon/calendar.svg'),
          const SizedBox(width: 8),
          Text(
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Lato',
            ),
          ),
        ],
      ),
    );
  }
}
