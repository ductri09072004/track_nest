import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BtnChooseAi extends StatefulWidget {
  // Hàm callback

  const BtnChooseAi({
    Key? key,
    required this.iconPath,
    required this.onModelSelected, // Nhận callback từ ngoài
  }) : super(key: key);
  final String iconPath;
  // ignore: inference_failure_on_function_return_type
  final Function(String) onModelSelected;

  @override
  _BtnChooseAiState createState() => _BtnChooseAiState();
}

class _BtnChooseAiState extends State<BtnChooseAi> {
  String _selectedText = 'Choose model AI';

  void _showPopup(BuildContext context) {
    // ignore: inference_failure_on_function_invocation
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select model AI',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                _buildOptionButton(
                  context,
                  'GPT-4',
                  'Premium +',
                  'lib/assets/icon/OCR_icon/gpt_ai.svg',
                ),
                const SizedBox(height: 20),
                _buildOptionButton(
                  context,
                  'Nest_AI',
                  'Free',
                  'lib/assets/icon/OCR_icon/nest_ai.svg',
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(
    BuildContext context,
    String text,
    String free,
    String iconPath,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _selectedText = text;
            });
            widget.onModelSelected(text); // Gọi callback để gửi giá trị
            Navigator.pop(context);
          },
          child: Row(
            children: [
              SvgPicture.asset(iconPath, width: 24, height: 24),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Lato',
                ),
              ),
              const Spacer(),
              Text(
                free,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF39FF14),
                  fontFamily: 'Lato',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton(
              onPressed: () => _showPopup(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(widget.iconPath),
                  const SizedBox(width: 12),
                  Text(
                    _selectedText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lato',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  SvgPicture.asset(widget.iconPath),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
