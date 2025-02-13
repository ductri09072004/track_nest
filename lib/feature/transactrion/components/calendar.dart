import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TimePickerComponent extends StatefulWidget {
  const TimePickerComponent(
      {super.key, required void Function(DateTime newDate) onDateSelected});

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Lato',
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            GestureDetector(
              onTap: () => _selectDate(context),
              child: SvgPicture.asset(
                'lib/assets/icon/transaction_icon/calendar.svg',
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: const TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: 'Lato'),
            ),
          ],
        ),
      ],
    );
  }
}
