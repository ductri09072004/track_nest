import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/feature/transactrion/components/Ex_In_btn.dart';
import 'package:testverygood/feature/transactrion/components/categories.dart';
import 'package:testverygood/feature/transactrion/components/calendar.dart';
import 'package:testverygood/components/input.dart';

class TransactionMain extends StatefulWidget {
  const TransactionMain({super.key});

  @override
  _TransactionMainState createState() => _TransactionMainState();
}

class _TransactionMainState extends State<TransactionMain> {
  final TextEditingController numericController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
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
                            SizedBox(height: 20),
                            Text('To', style: txmain),
                            InputClassic(
                              hintText: 'Hello',
                              hasBorder: false,
                              hasPadding: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Note', style: txmain),
                  const InputClassic(
                    hintText: 'Write your note',
                    hasBorder: false,
                    hasPadding: false,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Icon chọn ảnh
                      GestureDetector(
                        onTap: _pickImage,
                        child: SvgPicture.asset(
                          'lib/assets/icon/components_icon/cameraadd.svg',
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Hiển thị ảnh nếu đã chọn
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
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Button(
                    label: 'Save',
                    onPressed: () async {},
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
