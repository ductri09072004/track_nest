import 'dart:math';
import 'package:flutter/material.dart';
import 'package:testverygood/assets/core/appcolor.dart';
import 'package:testverygood/data/data_api/add_mempay_api.dart';

class FriendToggleList extends StatefulWidget {
  const FriendToggleList({
    super.key,
    required this.options,
    required this.initialToggleStates,
    required this.onChanged,
    this.selectedOption,
    required this.splitAmounts,
  });

  final List<double> splitAmounts;
  final List<String> options;
  final List<bool> initialToggleStates;
  final String? selectedOption;
  final Function(int, bool) onChanged;

  @override
  _FriendToggleListState createState() => _FriendToggleListState();
}

class _FriendToggleListState extends State<FriendToggleList> {
  late List<bool> toggleStates;

  @override
  void initState() {
    super.initState();
    toggleStates = List.from(widget.initialToggleStates);
  }

  static String generateGtransId() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(10, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  void _handleToggleChange(BuildContext context, int index, bool newValue) {
    setState(() {
      toggleStates[index] = newValue;
    });
    widget.onChanged(index, newValue);
  }

  // 🛠 Hàm lưu tất cả giao dịch khi nhấn nút
  Future<void> _saveAllTransactions(BuildContext context) async {
    try {
      String payid = generateGtransId(); // Tạo payid duy nhất cho lần lưu này
      List<Future<void>> apiCalls = [];

      for (int i = 0; i < widget.options.length; i++) {
        if (toggleStates[i]) {
          int money = widget.splitAmounts[i].toInt();
          String name = widget.options[i];

          // Kiểm tra dữ liệu trước khi gửi
          if (money <= 0 || name.isEmpty || payid.isEmpty) {
            throw Exception(
              'Thiếu dữ liệu: money=$money, name=$name, payid=$payid',
            );
          }

          // Gửi API và lưu vào danh sách
          apiCalls.add(
            TransactionService.saveTransaction(
              context: context,
              money: money,
              name: name,
              payid: payid,
              status: 'false',
            ),
          );
        }
      }

      // Chờ tất cả các API hoàn tất
      await Future.wait(apiCalls);

      // Hiển thị thông báo thành công nếu không có lỗi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lưu dữ liệu thành công!')),
      );
    } catch (e) {
      // Hiển thị thông báo lỗi nếu có
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi lưu dữ liệu: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.options.asMap().entries.map((entry) {
          final index = entry.key;
          final friend = entry.value;

          if (widget.selectedOption == friend) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Switch(
                  value: toggleStates[index],
                  onChanged: (newValue) =>
                      _handleToggleChange(context, index, newValue),
                  activeColor: Colors.white,
                  activeTrackColor: Color(0xFF013CBC),
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.black12,
                ),
                const SizedBox(width: 16),
                Text(
                  friend,
                  style: const TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.splitAmounts.length > index
                      ? '${widget.splitAmounts[index].toStringAsFixed(0)}.000 VND'
                      : '0 VND',
                  style: const TextStyle(
                    color: AppColor.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        ElevatedButton(
          onPressed: () => _saveAllTransactions(context),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Save',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
