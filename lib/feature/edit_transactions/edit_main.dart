import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:testverygood/components/component_app/HeaderA.dart';
import 'package:testverygood/components/component_app/input.dart';
import 'package:testverygood/feature/transactrion/components/calendar.dart';
import 'package:testverygood/feature/main_navbar.dart';
import 'package:testverygood/components/component_app/Edit&Delete_btn.dart';

class EditMain extends StatefulWidget {
  const EditMain({
    super.key,
    this.transid = '',
    this.icon = const SizedBox(),
  });

  final String transid;
  final Widget icon;

  @override
  _EditMainState createState() => _EditMainState();
}

class _EditMainState extends State<EditMain> {
  String? imageCloud;

  bool isExpense = true;
  String? uuid;
  String? exIn;
  String? rootKey;
  DateTime selectedDate = DateTime.now();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController numericController = TextEditingController();
  String? cateid;
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
    if (widget.transid.isNotEmpty) {
      fetchData();
    }
  }

  Future<void> fetchData() async {
    if (widget.transid.isEmpty) {
      throw Exception('transid is not loaded');
    }

    final response = await http.get(
      Uri.parse('http://3.26.221.69:5000/api/transactions'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      for (var entry in data.entries) {
        var transaction = entry.value as Map<String, dynamic>;
        if (transaction['trans_id'] == widget.transid) {
          setState(() {
            rootKey = entry.key; // Lưu key gốc
            numericController.text = transaction['money'].toString();
            noteController.text = transaction['note'].toString();
            fromController.text = transaction['tofrom'].toString();
            cateid = transaction['cate_id'].toString();
            imageCloud = transaction['pic'].toString();
            exIn = transaction['type'].toString();
          });
          break; // Thoát khỏi vòng lặp sau khi tìm thấy
        }
      }

      if (rootKey == null) {
        throw Exception(
            'Không tìm thấy giao dịch với trans_id: ${widget.transid}');
      }
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  Future<void> updateTransaction() async {
    if (rootKey == null) {
      throw Exception('Không tìm thấy key gốc để cập nhật');
    }

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://3.26.221.69:5000/api/transactions/$rootKey');

    final Map<String, dynamic> updatedData = {
      'money': int.tryParse(numericController.text) ?? 0,
      'note': noteController.text,
      'tofrom': fromController.text,
      'date': '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
    };

    try {
      final response = await http.put(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật giao dịch thành công!')),
        );
        navigateToTargetPage(context);
      } else {
        throw Exception('Cập nhật thất bại, mã lỗi: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $error')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteTransaction() async {
    if (rootKey == null) {
      throw Exception('Không tìm thấy key gốc để xóa');
    }

    final url = Uri.parse('http://3.26.221.69:5000/api/transactions/$rootKey');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Xóa giao dịch thành công!')),
        );
        Navigator.pop(context); // Quay lại màn hình trước sau khi xóa
      } else {
        throw Exception('Xóa thất bại, mã lỗi: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $error')),
      );
    }
  }

  void navigateToTargetPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      // ignore: inference_failure_on_instance_creation
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

  Future<void> handleEditTransaction(BuildContext context) async {
    await Future.wait([updateTransaction()]);

    navigateToTargetPage(context); // Chuyển trang sau khi cả hai hoàn tất
  }

  Future<void> handleDeleteTransaction(BuildContext context) async {
    await Future.wait([deleteTransaction()]);

    navigateToTargetPage(context); // Chuyển trang sau khi cả hai hoàn tất
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderA(title: 'Transaction'),
      body: Column(
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
                        child: Text(exIn.toString()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10), // Tạo padding 10
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.icon,
                            Text(
                              cateid ?? '',
                              style: txtitleicon,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Amount', style: txmain),
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
                          ],
                        ),
                      ),
                    ],
                  ),
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
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: EditDeleteButtons(
              onEdit: () => handleEditTransaction(context),
              onDelete: () => handleDeleteTransaction(context),
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle txmain =
      TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Lato');
  static const TextStyle txtd =
      TextStyle(color: Colors.black, fontSize: 30, fontFamily: 'Lato');

  static const TextStyle txtitleicon =
      TextStyle(color: Colors.black, fontSize: 14);
}
