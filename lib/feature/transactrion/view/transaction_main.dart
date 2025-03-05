import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testverygood/components/component_app/HeaderA.dart';
import 'package:testverygood/components/component_app/input.dart';
import 'package:testverygood/feature/transactrion/components/Ex_In_btn.dart';
import 'package:testverygood/feature/transactrion/components/calendar.dart';
import 'package:testverygood/feature/transactrion/components/categories.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:testverygood/feature/main_navbar.dart';
import 'package:testverygood/components/data_api/add_trans.dart';

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
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
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

  Future<void> handleSaveTransaction(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    bool success = await TransactionService.saveTransaction(
      uuid: uuid,
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      money: numericController.text,
      note: noteController.text,
      toFrom: fromController.text,
      imageFile: _selectedImage,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Saved transaction successfully!')),
      );
      navigateToTargetPage(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save transaction')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  void navigateToTargetPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      // ignore: inference_failure_on_instance_creation
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  Future<void> handleSaveTransactionfinall(BuildContext context) async {
    await Future.wait([
      _loadInterstitialAd(), // Chạy quảng cáo
      handleSaveTransaction(context), // Chạy lưu giao dịch
    ]);

    navigateToTargetPage(context); // Chuyển trang sau khi cả hai hoàn tất
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderA(title: 'Transaction'),
      body: Container(
        color: Colors.white, // Đặt màu nền tại đây
        child: Column(
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
                      onPressed: isLoading
                          ? null
                          : () => handleSaveTransactionfinall(context),
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
      ),
    );
  }

  static const TextStyle txmain =
      TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Lato');
  static const TextStyle txtd =
      TextStyle(color: Colors.black, fontSize: 30, fontFamily: 'Lato');
}
