import 'package:flutter/material.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/feature/transactrion/components/Ex_In_btn.dart';
import 'package:testverygood/feature/transactrion/components/categories.dart';
import 'package:testverygood/feature/transactrion/components/calendar.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/components/input.dart';

class TransactionMain extends StatefulWidget {
  const TransactionMain({super.key});

  @override
  _SplitPageState createState() => _SplitPageState();
}

class _SplitPageState extends State<TransactionMain> {
  final TextEditingController numericController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderA(title: 'Transaction'),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                // Đảm bảo nút trượt chiếm toàn bộ chiều ngang
                child: ExInBtn(
                  labels: const ['Expenses', 'Income'],
                  onToggle: (index) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Amount', style: txmain),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: InputField(
                  hintText: '0',
                  controller: numericController,
                  isNumeric: true,
                  maxLength: 9,
                  onChanged: (value) {
                    setState(() {
                      // Cập nhật số tiền khi người dùng thay đổi
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              const Text('VND', style: txtd),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Categories', style: txmain),
          const SizedBox(height: 10),
          const CategoriesText(),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                child: TimePickerComponent(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text('Categories', style: txmain),
                    // const SizedBox(height: 20),
                    InputClassic(
                      hintText: 'Hello',
                      hasBorder: false,
                      hasPadding: false,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  static const TextStyle txmain =
      TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Lato');
  static const TextStyle txprice =
      TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Lato');
  static const TextStyle txtd =
      TextStyle(color: Colors.black, fontSize: 30, fontFamily: 'Lato');
  static const TextStyle txtpeo =
      TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Lato_Regular');
}
