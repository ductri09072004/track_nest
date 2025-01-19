import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/dropdown.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/components/button.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});

  @override
  _SplitPageState createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  String? selectedOption;
  final List<String> options = ['Trí', 'Trâm', 'Phúc'];
  String? selectedOption2;
  final List<String> options2 = ['Eually', 'As amounts'];
  final TextEditingController numericController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  bool isSwitched = false;
  @override
  void dispose() {
    numericController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderA(title: 'Split'),
      body: Padding(
        padding: const EdgeInsets.all(20), // Thêm padding vào các cạnh
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Canh trái cho nội dung
          children: [
            const Text(
              'Paid by',
              style: txmain,
            ),
            const SizedBox(height: 10),
            Dropdown(
              selectedValue: selectedOption,
              options: options,
              hintText: 'Choose who will pay',
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Amount',
              style: txmain,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    hintText: '0',
                    controller: numericController,
                    isNumeric: true,
                    maxLength: 9,
                  ),
                ),
                const SizedBox(width: 8), // Khoảng cách giữa InputField và Text
                const Text('đ', style: txtd),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Split with',
                  style: txmain,
                ),
                const Spacer(),
                Container(
                  width: 143, // Đặt chiều rộng tùy ý
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Dropdown(
                    selectedValue: selectedOption2,
                    options: options2,
                    hintText: 'Eually',
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption2 = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  child: ToggleSwitch(
                    value: isSwitched,
                    onChanged: (newValue) {
                      setState(() {
                        isSwitched = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text('Mri', style: txtpeo),
                const Spacer(),
                const Text('200.000 đ', style: txtpeo),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Categories',
              style: txmain,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Time',
                      style: txmain,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'lib/assets/icon/components_icon/calendar.svg',
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          '1/1/2025',
                          style: txtpeo,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  width: 40,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Note',
                      style: txmain,
                    ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: InputField(
                    //     hintText: 'yooo0',
                    //     controller: noteController,
                    //     maxLength: 9,
                    //     isSmallText: true,
                    //   ),
                    // ),
                    Text(
                      'yoo',
                      style: txtpeo,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Button(
                    label: 'Save', // Thẻ văn bản cho nút
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static const TextStyle txmain =
      TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Lato');
  static const TextStyle txtd =
      TextStyle(color: Colors.black, fontSize: 30, fontFamily: 'Lato');
  static const TextStyle txtpeo =
      TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Lato_Regular');
}
