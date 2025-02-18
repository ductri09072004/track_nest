import 'package:flutter/material.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/input.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  _BodyMainState createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  String? selectedOption2;
  final List<String> options2 = ['Option 1', 'Option 2', 'Option 3'];
  final TextEditingController numericController = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    numericController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Group name', style: txtcate),
              const SizedBox(height: 10),
              const InputClassic(
                hintText: 'Enter your group name',
              ),
              const SizedBox(height: 16),
              const Text('Members', style: txtcate),
              InputWithClearIcon(
                hintText: 'Enter name',
                controller: _controller,
              ),
              const SizedBox(height: 16),
              const Text('Add new member', style: txtnew),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      label: 'Save',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã lưu!'),
                            duration:
                                Duration(seconds: 2), // Thời gian hiển thị
                          ),
                        );
                      },
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

  static const TextStyle txtcate = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Lato',
  );

  static const TextStyle txtnew = TextStyle(
    color: Color(0xFF3B82F6),
    fontSize: 16,
    fontFamily: 'Lato_Regular',
  );
}
