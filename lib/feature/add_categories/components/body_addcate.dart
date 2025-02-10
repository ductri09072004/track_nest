import 'package:flutter/material.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/feature/transactrion/components/Ex_In_btn.dart';

class AddCatePage extends StatelessWidget {
  const AddCatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
