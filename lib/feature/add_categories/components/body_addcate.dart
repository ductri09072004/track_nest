import 'package:flutter/material.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/feature/transactrion/components/Ex_In_btn.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // padding: const EdgeInsets.all(20),
        children: [
          // const SizedBox(height: 16),
          const Text('Type', style: txmain,),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                // Đảm bảo nút trượt chiếm toàn bộ chiều ngang
                child: ExInBtn(
                  labels: const ['Expenses', 'Income'],
                  onToggle: (index) {},
                ),
              ),
              // const Expanded(child: Text('ddfasdfata')),
            ],
          ),
          const SizedBox(height: 16,),
          const Text('Icon',style: txmain,),
          const SizedBox(height: 10,),
          const InputClassic(hintText: '🎁'),
          const SizedBox(height: 16,),
          const Text('Category name',style: txmain,),
          const SizedBox(height: 10,),
          const InputClassic(hintText: 'Present'),
          const SizedBox(height: 16,),
          Row(
            children: [
              Expanded(
                child: Button(
                  label: 'Save',
                  onPressed: () {},
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
