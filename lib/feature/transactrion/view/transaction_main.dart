import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/feature/transactrion/components/Ex_In_btn.dart';
import 'package:testverygood/feature/transactrion/components/calendar.dart';
import 'package:testverygood/feature/transactrion/components/categories.dart';

class TransactionMain extends StatefulWidget {
  const TransactionMain({Key? key, this.data = ''}) : super(key: key);
  final String data;

  @override
  _TransactionMainState createState() => _TransactionMainState();
}

class _TransactionMainState extends State<TransactionMain> {
  File? _selectedImage;
  bool isExpense = true;
  String? uuid;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  DateTime selectedDate = DateTime.now();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController numericController = TextEditingController();
  String selectedCategory = 'Chưa chọn danh mục';

  void _updateSelectedDate(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  String generateCateId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        10,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUUID(); // Lấy UUID khi widget khởi tạo

    if (widget.data.isNotEmpty) {
      numericController.text = widget.data;
    }
  }

  Future<void> _loadUUID() async {
    final storedUUID = await storage.read(key: 'unique_id');
    setState(() {
      uuid = storedUUID ?? 'Không tìm thấy UUID';
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> saveTransaction() async {
    try {
      final url = Uri.parse(
        'http://3.26.221.69:5000/api/transactions', //192.168.1.16
      );

      final transactionData = <String, dynamic>{
        'cate_id': selectedCategory,
        'date':
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
        'money': int.tryParse(numericController.text.replaceAll('.', '')) ?? 0,
        'note': noteController.text.isNotEmpty ? noteController.text : '',
        'pic': 'picture.com',
        'tofrom': fromController.text.isNotEmpty ? fromController.text : '',
        'trans_id': generateCateId(),
        'type': isExpense ? 'expense' : 'income',
        'user_id': uuid,
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Định dạng JSON
        },
        body: jsonEncode(transactionData), // Chuyển Map thành JSON string
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Giao dịch đã được lưu: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lưu giao dịch thành công!')),
        );
      } else {
        print(
          'Lỗi khi lưu giao dịch: ${response.statusCode} - ${response.body}',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lưu thất bại: ${response.body}')),
        );
      }
    } catch (e) {
      print('Lỗi: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderA(title: 'Transaction'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ExInBtn(
                          labels: const ['Expenses', 'Income'],
                          onToggle: (index) {
                            setState(() {
                              isExpense = index == 0;
                            });
                          },
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
                            setState(() {});
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
                  CategoriesText(
                    isExpense: isExpense,
                    onCategorySelected: (String category) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Time', style: txmain),
                            const SizedBox(height: 12),
                            TimePickerComponent(
                              onDateSelected: _updateSelectedDate,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text('From', style: txmain),
                            InputClassic(
                              hintText: 'Write name',
                              hasBorder: false,
                              hasPadding: false,
                              controller: fromController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Note', style: txmain),
                  InputClassic(
                    hintText: 'Write your note',
                    hasBorder: false,
                    hasPadding: false,
                    controller: noteController,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (_selectedImage != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _selectedImage!,
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                          ),
                        ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: SvgPicture.asset(
                          'lib/assets/icon/components_icon/cameraadd.svg',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Button(
                    label: 'Save',
                    onPressed: saveTransaction,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle txmain =
      TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Lato');
  static const TextStyle txtd =
      TextStyle(color: Colors.black, fontSize: 30, fontFamily: 'Lato');
}
