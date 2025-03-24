import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/bootstrap.dart';
import 'package:testverygood/features/settings/subcription/view/subcription_main.dart';

class BtnChooseAi extends StatefulWidget {
  const BtnChooseAi({
    required this.iconPath,
    required this.onModelSelected, // Hàm callback nhận từ ngoài
    required this.selectedModel,
    super.key,
  });

  final String iconPath;
  final String selectedModel;
  final Function(String) onModelSelected; // Callback khi chọn model

  @override
  _BtnChooseAiState createState() => _BtnChooseAiState();
}

Future<String?> loadTypeId() async {
  return storage.read(key: 'type_id');
}

class _BtnChooseAiState extends State<BtnChooseAi> {
  late String _selectedText;

  @override
  void initState() {
    super.initState();
    _selectedText =
        widget.selectedModel.isNotEmpty ? widget.selectedModel : 'Nest_AI';
  }

  void navigateToTargetPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UpgradeAccountPage()),
    );
  }

  void _showPopup(BuildContext context) {
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
                _buildOptionButton(context, 'GPT-4', 'Premium',
                    'lib/assets/icon/OCR_icon/gpt_ai.svg',),
                const SizedBox(height: 20),
                _buildOptionButton(context, 'Nest_AI', 'Free',
                    'lib/assets/icon/OCR_icon/nest_ai.svg',),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionButton(
      BuildContext context, String text, String planType, String iconPath,) {
    return FutureBuilder<String?>(
      future: loadTypeId(),
      builder: (context, snapshot) {
        String? typeId = snapshot.data;
        bool isPremium = typeId == 'premium';

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
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),),
                backgroundColor: Colors.black,
              ),
              onPressed: () {
                if (text == 'GPT-4' && !isPremium) {
                  navigateToTargetPage(context); // Chuyển hướng nếu Free
                } else {
                  setState(() {
                    _selectedText = text;
                  });
                  widget.onModelSelected(text);
                  Navigator.pop(context);
                }
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
                    planType,
                    style: TextStyle(
                      fontSize: 18,
                      color: planType == 'Premium'
                          ? const Color(0xFF39FF14)
                          : const Color(0xFF808080),
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
                  SvgPicture.asset(
                    widget.iconPath,
                    width: 32,
                    height: 32,
                  ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
