import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testverygood/features/groupsplit/add_split/app.dart'; // Import màn hình chia tiền
import 'package:testverygood/features/transaction/add_trans/app.dart';
import 'package:testverygood/features/transaction/scanbill/widgets/ExtractedInfo.dart';
import 'package:testverygood/features/transaction/scanbill/widgets/button_add.dart'; // Import màn hình giao dịch

class BtnSuccess extends StatelessWidget {
  const BtnSuccess({
    Key? key,
    required this.extractedText,
    required this.extracteDate,
    required this.imageTransaction,
    required this.onRescan,
    required this.extractedCate,
  }) : super(key: key);

  final String extractedText;
  final String imageTransaction;
  final VoidCallback onRescan;
  final String extracteDate;
  final String extractedCate;

  String formatCurrency(String value) {
    try {
      final number = int.parse(value);
      return NumberFormat.currency(locale: 'vi_VN', symbol: 'VND')
          .format(number);
    } catch (e) {
      return value; // Trả về giá trị ban đầu nếu có lỗi
    }
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      // ignore: inference_failure_on_instance_creation
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: Colors.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Scan bill completed successfully!',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              ExtractedInfo(
                label: 'Choose which transaction you want to add',
                value: formatCurrency(extractedText),
                prefixText: 'Total money bill:',
              ),
              ExtractedInfo(
                label: 'Choose which transaction you want to add',
                value: formatCurrency(extracteDate),
                prefixText: 'Date bill:',
              ),
              ExtractedInfo(
                label: 'Choose which transaction you want to add',
                value: extractedCate,
                prefixText: 'Categories bill:',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ButtonAdd(
                      text: 'Add to split bill',
                      onPressed: () => _navigateToScreen(
                        context,
                        SplitPage(data: extractedText),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ButtonAdd(
                      text: 'Add to transaction',
                      onPressed: () => _navigateToScreen(
                        context,
                        TransactionMain(
                          money: extractedText,
                          date: extracteDate,
                          cate: extractedCate,
                          imageTransaction: imageTransaction,
                        ),
                      ),
                      borderColor: const Color(0xFF013CBC),
                    ),
                  ),
                  Expanded(
                    child: ButtonAdd(
                      text: 'Scan bill again',
                      onPressed: onRescan,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
