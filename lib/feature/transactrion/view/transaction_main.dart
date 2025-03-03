import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/feature/transactrion/components/Ex_In_btn.dart';
import 'package:testverygood/feature/transactrion/components/calendar.dart';
import 'package:testverygood/feature/transactrion/components/categories.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testverygood/feature/main_navbar.dart';

class TransactionMain extends StatefulWidget {
  const TransactionMain({Key? key, this.data = '', this.imageTransaction = ''})
      : super(key: key);

  final String data;
  final String imageTransaction; // Nhận thêm imageTransaction

  @override
  _TransactionMainState createState() => _TransactionMainState();
}

class _TransactionMainState extends State<TransactionMain> {
  File? _selectedImage;
  InterstitialAd? _interstitialAd;
  bool isExpense = true;
  String? uuid;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  DateTime selectedDate = DateTime.now();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController numericController = TextEditingController();
  String selectedCategory = '';
  bool isLoading = false;

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
    if (widget.imageTransaction.isNotEmpty) {
      _selectedImage = File(widget.imageTransaction);
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

  Future<void> _loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712', // ID quảng cáo test
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialAd!.show(); // Hiển thị ngay khi load xong
        },
        onAdFailedToLoad: (LoadAdError error) {},
      ),
    );
  }

  Future<String?> _uploadImageToCloudinary(File imageFile) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/dcdaz0dzb/image/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'blueduck'
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = jsonDecode(await response.stream.bytesToString())
          as Map<String, dynamic>;
      return responseData['secure_url'] as String?;
    } else {
      print('Lỗi khi tải ảnh lên Cloudinary: ${response.reasonPhrase}');
      return null;
    }
  }

  Future<void> saveTransaction() async {
    setState(() {
      isLoading = true; // Hiển thị vòng xoay
    });
    try {
      final url = Uri.parse(
        'http://3.26.221.69:5000/api/transactions', //192.168.1.16
      );
      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await _uploadImageToCloudinary(_selectedImage!);
      }

      final transactionData = <String, dynamic>{
        'cate_id': selectedCategory,
        'date':
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
        'money': int.tryParse(numericController.text.replaceAll('.', '')) ?? 0,
        'note': noteController.text.isNotEmpty ? noteController.text : '',
        'pic': imageUrl,
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
          const SnackBar(content: Text('Saved transaction successfully!')),
        );
      } else {
        print(
          'Lỗi khi lưu giao dịch: ${response.statusCode} - ${response.body}',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved failed: ${response.body}')),
        );
      }
    } catch (e) {
      print('Lỗi: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi: $e')),
      );
    } finally {
      setState(() {
        isLoading = false; // Ẩn vòng xoay sau khi hoàn tất
      });
    }
  }

  void navigateToTargetPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      // ignore: inference_failure_on_instance_creation
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  Future<void> handleSaveTransaction(BuildContext context) async {
    await Future.wait([
      _loadInterstitialAd(), // Chạy quảng cáo
      saveTransaction(), // Chạy lưu giao dịch
    ]);

    navigateToTargetPage(context); // Chuyển trang sau khi cả hai hoàn tất
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
                      if (_selectedImage != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _selectedImage!,
                            width: 76,
                            height: 76,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16), // Chỉ hiển thị khi có ảnh
                      ],
                      GestureDetector(
                        onTap: _pickImage,
                        child: SvgPicture.asset(
                          'lib/assets/icon/components_icon/cameraadd.svg',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        isLoading ? null : () => handleSaveTransaction(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF791CAC),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Save',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static const TextStyle txmain =
      TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Lato');
  static const TextStyle txtd =
      TextStyle(color: Colors.black, fontSize: 30, fontFamily: 'Lato');
}
