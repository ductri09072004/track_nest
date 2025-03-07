import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/components/input.dart';
import 'package:testverygood/features/transaction/add_trans/components/Ex_In_btn.dart';
import 'package:testverygood/data/data_api/add_cate.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  _BodyMainState createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  final storage = const FlutterSecureStorage();
  String? uuid;
  bool isExpense = true;

  final TextEditingController iconController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final FocusNode iconFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadUUID();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusScope.of(context).requestFocus(iconFocusNode);
      }
    });
  }

  @override
  void dispose() {
    iconFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadUUID() async {
    final storedUUID = await storage.read(key: 'unique_id');
    setState(() {
      uuid = storedUUID;
    });
  }

  void _handleSaveTransaction() {
    if (uuid != null) {
      TransactionService.saveTransaction(
        context: context,
        uuid: uuid!,
        icon: iconController.text,
        name: nameController.text,
        isExpense: isExpense,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy UUID!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Type', style: txmain),
            const SizedBox(height: 10),
            ExInBtn(
              labels: const ['Expenses', 'Income'],
              onToggle: (index) {
                setState(() {
                  isExpense = index == 0;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Icon', style: txmain),
            const SizedBox(height: 10),
            InputClassic(
              controller: iconController,
              hintText: 'Add icon',
              focusNode: iconFocusNode,
            ),
            const SizedBox(height: 16),
            const Text('Category name', style: txmain),
            const SizedBox(height: 10),
            InputClassic(controller: nameController, hintText: 'Add name'),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Button(
                    label: 'Save',
                    onPressed: _handleSaveTransaction,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static const TextStyle txmain =
      TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Lato');
}
