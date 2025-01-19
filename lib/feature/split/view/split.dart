import 'package:flutter/material.dart';
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
  String? selectedOption; // Biến lưu trữ giá trị đã chọn
  final List<String> options = ['Trí', 'Trâm', 'Phúc'];
  final TextEditingController numericController = TextEditingController();
  bool isSwitched = false;
  @override
  void dispose() {
    // Hủy bộ điều khiển khi không còn sử dụng
    numericController.dispose();
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
            const Text(
              'Split with',
              style: txmain,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Mri', style: txtpeo),
                const Spacer(),
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
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Categories',
              style: txmain,
            ),
            const SizedBox(height: 16),
            const Text(
              'Note',
              style: txmain,
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
