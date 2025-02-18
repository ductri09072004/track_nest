import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:testverygood/components/date.dart'; // Import HorizontalList từ đây

class HeaderMain extends StatefulWidget {
  const HeaderMain({
    super.key,
    this.showBalance = true,
    this.showIcons = true,
    this.showHorizontalList = true,
    this.showTitle = true,
  });

  final bool showBalance;
  final bool showIcons;
  final bool showHorizontalList;
  final bool showTitle;

  @override
  _HeaderMainState createState() => _HeaderMainState();
}

class _HeaderMainState extends State<HeaderMain> {
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  int currentYear = DateTime.now().year;
  final int minYear = DateTime.now().year - 10;
  final int maxYear = DateTime.now().year + 10;

  void _showMonthPickerDialog(BuildContext context) {
    showMonthPicker(
      context: context,
      initialDate: DateTime(selectedYear, selectedMonth),
      firstDate: DateTime(minYear),
      lastDate: DateTime(maxYear),
    ).then((date) {
      if (date != null) {
        setState(() {
          selectedMonth = date.month;
          selectedYear = date.year;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You selected ${date.month} ${date.year}'),
          ),
        );
      }
    });
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Icon(Icons.restaurant),
                      Text('Eating'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.restaurant),
                      Text('Eating'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.restaurant),
                      Text('Eating'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.restaurant),
                      Text('Eating'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'February 2025',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'May 2025',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Xử lý tìm kiếm nếu cần
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: const Color(0xFFA561CA),
          ),
        ),
        Positioned.fill(
          top: -290,
          right: -180,
          child: SvgPicture.asset(
            'lib/assets/svg/Background.svg',
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 55,
                left: 20,
                right: 20,
              ),
              child: Row(
                children: [
                  const Spacer(),
                  if (widget.showIcons)
                    GestureDetector(
                      onTap: () => _showMonthPickerDialog(context),
                      child: SvgPicture.asset(
                        'lib/assets/icon/home_icon/calendar_icon.svg',
                      ),
                    )
                  else
                    const SizedBox(width: 24),
                  const SizedBox(width: 24),
                  if (widget.showIcons)
                    GestureDetector(
                      onTap: () => _showSearchDialog(context),
                      child: SvgPicture.asset(
                        'lib/assets/icon/home_icon/search_icon.svg',
                      ),
                    )
                  else
                    const SizedBox(width: 24),
                  // const SizedBox(width: 24),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (widget.showHorizontalList) const HorizontalList(),
            const SizedBox(height: 30),
            if (widget.showBalance)
              const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Balance',
                      style: texttop,
                    ),
                    Text(
                      '2.000.000 đ',
                      style: whiteTextStyle,
                    ),
                  ],
                ),
              ),
            if (widget.showTitle)
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Setting',
                      style: texttitle,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  static const TextStyle whiteTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    fontFamily: 'Lato',
  );

  static const TextStyle texttop =
      TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Lato');
  static const TextStyle texttitle =
      TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Lato');
}
