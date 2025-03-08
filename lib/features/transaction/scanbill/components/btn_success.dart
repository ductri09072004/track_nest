import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testverygood/features/groupsplit/add_split/app.dart'; // Import màn hình chia tiền
import 'package:testverygood/features/transaction/add_trans/app.dart'; // Import màn hình giao dịch

class BtnSuccess extends StatelessWidget {
  const BtnSuccess({
    Key? key,
    required this.extractedText,
    required this.imageTransaction,
    required this.onRescan,
  }) : super(key: key);

  final String extractedText; // Số tiền trích xuất từ bill
  final String imageTransaction;
  final VoidCallback onRescan;

  String formatCurrency(String value) {
    try {
      var number = int.parse(value);
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
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24),
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
              const SizedBox(height: 12),
              if (extractedText.isNotEmpty)
                Text(
                  formatCurrency(extractedText),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    color: Colors.black,
                  ),
                )
              else
                const Text(
                  'Choose which transaction you want to add',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    color: Colors.black,
                  ),
                ),
              const SizedBox(height: 12),
              _buildButton(
                text: 'Add to personal transaction',
                onPressed: () => _navigateToScreen(
                  context,
                  TransactionMain(
                    data: extractedText,
                    imageTransaction: imageTransaction,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildButton(
                text: 'Add to group transaction (split bill)',
                onPressed: () => _navigateToScreen(
                  context,
                  SplitPage(data: extractedText),
                ),
              ),
              const SizedBox(height: 10),
              _buildButton(text: 'Scan the text again', onPressed: onRescan),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 55, 54, 114).withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor: Colors.white,
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Lato',
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
