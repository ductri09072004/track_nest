import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testverygood/feature/transactrion/app.dart'; // Import màn hình giao dịch
import 'package:testverygood/feature/split/app.dart'; // Import màn hình chia tiền

class BtnSuccess extends StatelessWidget {
  const BtnSuccess({
    Key? key,
    required this.extractedText,
    required this.onRescan,
  }) : super(key: key);
  final String extractedText; // Số tiền trích xuất từ bill
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
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  TransactionMain(data: extractedText),
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
                color: const Color(0xff761C9A).withOpacity(0.5),
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
