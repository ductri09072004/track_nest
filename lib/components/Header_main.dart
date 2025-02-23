import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/components/categories.dart';
import 'package:testverygood/components/date.dart';
import 'package:testverygood/components/selectMonth.dart';
import 'package:testverygood/components/filterSearch.dart';

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
  ValueNotifier<DateTime> selectedMonth = ValueNotifier<DateTime>(DateTime.now());

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
                      onTap: () => showMonthPickerDialog(
                          context, selectedMonth,), // Gọi từ selectMonth.dart
                      child: SvgPicture.asset(
                        'lib/assets/icon/home_icon/calendar_icon.svg',
                      ),
                    )
                  else
                    const SizedBox(width: 24),
                  const SizedBox(width: 24),
                  if (widget.showIcons)
                    GestureDetector(
                      onTap: () =>
                          showSearchDialog(context), // Gọi từ filterSearch.dart
                      child: SvgPicture.asset(
                        'lib/assets/icon/home_icon/search_icon.svg',
                      ),
                    )
                  else
                    const SizedBox(width: 24),
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
