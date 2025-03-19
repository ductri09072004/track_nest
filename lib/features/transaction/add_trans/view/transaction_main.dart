import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/data/data_api/add_trans_api.dart';
import 'package:testverygood/features/main_navbar.dart';
import 'package:testverygood/components/Ex_In_btn_Satis.dart';
import 'package:testverygood/features/transaction/add_trans/widgets/calendar.dart';
import 'package:testverygood/features/transaction/add_trans/widgets/categories.dart';

class TransactionMain extends StatefulWidget {
  const TransactionMain(
      {Key? key,
      this.money = '',
      this.date = '',
      this.cate = '',
      this.imageTransaction = ''})
      : super(key: key);

  final String money;
  final String date;
  final String cate;

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

    if (widget.money.isNotEmpty) {
      numericController.text = widget.money;
    }
    if (widget.imageTransaction.isNotEmpty) {
      _selectedImage = File(widget.imageTransaction);
    }
    if (widget.date.isNotEmpty) {
      try {
        selectedDate = DateFormat('dd/MM/yyyy').parse(widget.date);
      } catch (e) {
        selectedDate = DateTime.now();
      }
    }
    if (widget.cate.isNotEmpty) {
      selectedCategory = widget.cate;
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

  Future<bool> handleSaveTransaction(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    final result = await TransactionService.saveTransaction(
      uuid: uuid,
      selectedCategory: selectedCategory,
      selectedDate: selectedDate,
      money: numericController.text,
      note: noteController.text,
      toFrom: fromController.text,
      imageFile: _selectedImage,
      type: isExpense ? 'expense' : 'income',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'].toString())),
    );

    setState(() {
      isLoading = false;
    });

    return result['success'] ==
        true; // Trả về true nếu thành công, false nếu thất bại
  }

  void navigateToTargetPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  Future<void> handleSaveTransactionfinall(BuildContext context) async {
    final saveResult =
        await handleSaveTransaction(context); // Lưu giao dịch trước

    if (saveResult == true) {
      // Chỉ tiếp tục nếu lưu giao dịch thành công
      await _loadInterstitialAd(); // Chạy quảng cáo
      navigateToTargetPage(context); // Chuyển trang
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderA(title: 'Transaction'),
      body: ColoredBox(
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
                          child: ExInBtnStatis(
                            labels: const ['Expense', 'Income'],
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
                      initialCategory: widget.cate,
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
                                initialDate: selectedDate,
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
                        backgroundColor: const Color(0xFF013CBC),
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
}
