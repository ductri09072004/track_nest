import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/feature/transactrion/components/Ex_In_btn.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  _BodyMainState createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  final storage = const FlutterSecureStorage();
  String? uuid;
  bool isExpense = true; // Mặc định là 'expense'

  final TextEditingController iconController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUUID();
  }

  Future<void> _loadUUID() async {
    final storedUUID = await storage.read(key: 'unique_id');
    setState(() {
      uuid = storedUUID;
    });
  }

  Future<void> saveTransaction() async {
    if (uuid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy UUID!')),
      );
      return;
    }

    if (nameController.text.isEmpty || iconController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đủ thông tin!')),
      );
      return;
    }

    try {
      final url = Uri.parse('http://3.26.221.69:5000/api/categories');

      final transactionData = {
        'icon': iconController.text,
        'name': nameController.text,
        'type': isExpense ? 'expense' : 'income',
        'user_id': uuid,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(transactionData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lưu giao dịch thành công!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lưu thất bại: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Type', style: txmain),
            const SizedBox(height: 10),
            ExInBtn(
              labels: const ['Expenses', 'Income'],
              onToggle: (index) {
                setState(() {
                  isExpense = index ==
                      0; // Nếu chọn "Expenses" thì true, ngược lại false
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Icon', style: txmain),
            const SizedBox(height: 10),
            InputClassic(controller: iconController, hintText: 'Add icon'),
            const SizedBox(height: 16),
            const Text('Category name', style: txmain),
            const SizedBox(height: 10),
            InputClassic(controller: nameController, hintText: 'Add name'),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Button(
                    label: 'Save',
                    onPressed: saveTransaction,
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
}
