import 'package:flutter/material.dart';
import 'package:testverygood/bootstrap.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/data/data_api/add_friends_api.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  _BodyMainState createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  final TextEditingController _groupNameController = TextEditingController();
  final List<TextEditingController> _controllers = [TextEditingController()];
  String? uuid;

  Future<void> _loadUUID() async {
    final storedUUID = await storage.read(key: 'unique_id');
    setState(() {
      uuid = storedUUID ?? 'Không tìm thấy UUID';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUUID(); // Lấy UUID khi widget khởi tạo
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addNewMember() {
    if (_controllers.last.text.isNotEmpty) {
      setState(() {
        _controllers.add(TextEditingController());
      });
    }
  }

  void _removeEmptyFields() {
    setState(() {
      if (_controllers.length > 1) {
        _controllers.removeWhere((controller) => controller.text.isEmpty);
      }
      if (_controllers.isEmpty || _controllers.last.text.isNotEmpty) {
        _controllers.add(TextEditingController());
      }
    });
  }

  Future<void> _saveGroup() async {
    String groupName = _groupNameController.text.trim();
    List<String> members = _controllers
        .map((controller) => controller.text.trim())
        .where((name) => name.isNotEmpty)
        .toList();

    if (groupName.isEmpty || members.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin!')),
      );
      return;
    }

    for (String member in members) {
      await TransactionService.saveTransaction(
        context: context,
        uuid: uuid ?? '',
        namegroup: groupName,
        namemen: member,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Group name', style: txtcate),
              const SizedBox(height: 10),
              InputClassic(
                hintText: 'Enter your group name',
                controller: _groupNameController,
              ),
              const SizedBox(height: 16),
              const Text('Members', style: txtcate),
              Column(
                children: _controllers.map((controller) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InputWithClearIcon(
                      hintText: 'Enter name',
                      controller: controller,
                      onChanged: (text) {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          _removeEmptyFields();
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _addNewMember,
                child: const Text('Add new member', style: txtnew),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Button(
                      label: 'Save',
                      onPressed: _saveGroup,
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
