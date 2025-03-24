import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testverygood/assets/core/appcolor.dart';
import 'package:testverygood/data/data_api/Split/add_mempay_api.dart';

class FriendToggleList extends StatefulWidget {
  const FriendToggleList({
    required this.options, required this.initialToggleStates, required this.onChanged, required this.splitAmounts, required this.onPayidGenerated, super.key,
    this.selectedOption,
  });

  final List<double> splitAmounts;
  final List<String> options;
  final List<bool> initialToggleStates;
  final String? selectedOption;
  final Function(int, bool) onChanged;
  final Function(String) onPayidGenerated;

  @override
  FriendToggleListState createState() => FriendToggleListState();
}

final GlobalKey<FriendToggleListState> friendToggleKey =
    GlobalKey<FriendToggleListState>();

class FriendToggleListState extends State<FriendToggleList> {
  late List<bool> toggleStates;

  @override
  void initState() {
    super.initState();
    toggleStates = List.from(widget.initialToggleStates);
    if (widget.selectedOption != null) {
      int payerIndex = widget.options.indexOf(widget.selectedOption!);
      if (payerIndex != -1) {
        toggleStates[payerIndex] = true; // Luôn đặt thành true
      }
    }
  }

  void _handleToggleChange(BuildContext context, int index, bool newValue) {
    setState(() {
      toggleStates[index] = newValue;
    });
    widget.onChanged(index, newValue);
  }

  Future<void> saveAllTransactions(BuildContext context) async {
    await TransactionService.saveAllTransactions(
      context: context,
      splitAmounts: widget.splitAmounts.map((e) => e.toInt()).toList(),
      options: widget.options,
      toggleStates: toggleStates,
      onPayidGenerated: (String payid) {
        setState(() {});
        widget.onPayidGenerated(payid);
      },
      selectedOption: widget.selectedOption ?? '',
    );
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,###', 'vi_VN');
    return '${formatter.format(amount)} VND';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.options.asMap().entries.map((entry) {
          final index = entry.key;
          final friend = entry.value;

          bool isPayer = widget.selectedOption == friend;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                if (!isPayer) // Chỉ cho phép bật/tắt với người khác
                  Switch(
                    value: toggleStates[index],
                    onChanged: (newValue) =>
                        _handleToggleChange(context, index, newValue),
                    activeColor: Colors.white,
                    activeTrackColor: const Color(0xFF013CBC),
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.black12,
                  ),
                if (isPayer)
                  const Icon(Icons.check_circle, color: Colors.green),
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
                      ? formatCurrency(widget.splitAmounts[index].toInt())
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
      ],
    );
  }
}
