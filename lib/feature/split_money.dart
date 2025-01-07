import 'package:flutter/material.dart';

class SplitMoneyPage extends StatefulWidget {
  const SplitMoneyPage({Key? key}) : super(key: key);

  @override
  State<SplitMoneyPage> createState() => _SplitMoneyPageState();
}

class _SplitMoneyPageState extends State<SplitMoneyPage> {
  final TextEditingController _payerController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final List<String> _people = ['Người A', 'Người B', 'Người C', 'Người D'];
  String _payer = '';
  final Set<String> _selectedSharedWith = {};
  String _result = '';

  void _autoCalculateSplit() {
    final double? amount = double.tryParse(_amountController.text);
    if (amount != null && _selectedSharedWith.isNotEmpty) {
      final int peopleCount = _selectedSharedWith.length;
      final double splitAmount = amount / peopleCount;
      setState(() {
        _result =
            'Mỗi người cần trả: ${splitAmount.toStringAsFixed(2)} VND\n(Chia cho: ${_selectedSharedWith.join(", ")})';
      });
    } else {
      setState(() {
        _result = 'Chưa đủ thông tin để tính tiền chia.';
      });
    }
  }

  void _showSharedWithPicker() async {
    final Set<String> tempSelected = {..._selectedSharedWith};

    final Set<String>? selected = await showDialog<Set<String>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter dialogSetState) {
            return AlertDialog(
              title: const Text('Chọn người chia tiền'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: _people.map((person) {
                  return CheckboxListTile(
                    title: Text(person),
                    value: tempSelected.contains(person),
                    onChanged: (bool? isChecked) {
                      dialogSetState(() {
                        if (isChecked == true) {
                          tempSelected.add(person);
                        } else {
                          tempSelected.remove(person);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, tempSelected);
                  },
                  child: const Text('Xong'),
                ),
              ],
            );
          },
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedSharedWith.clear();
        _selectedSharedWith.addAll(selected);
      });
      _autoCalculateSplit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            value: _payer.isNotEmpty ? _payer : null,
            items: _people.map((person) {
              return DropdownMenuItem(
                value: person,
                child: Text(person),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _payer = value ?? '';
              });
              _autoCalculateSplit();
            },
            decoration: const InputDecoration(
              labelText: 'Ai sẽ trả?',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nhập số tiền',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              _autoCalculateSplit();
            },
          ),
          const SizedBox(height: 16),
          TextField(
            readOnly: true,
            onTap: _showSharedWithPicker,
            decoration: InputDecoration(
              labelText: _selectedSharedWith.isEmpty
                  ? 'Chia với ai?'
                  : 'Chia với: ${_selectedSharedWith.join(", ")}',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          // TextField(
          //   controller: _noteController,
          //   decoration: const InputDecoration(
          //     labelText: 'Ghi chú',
          //     border: OutlineInputBorder(),
          //   ),
          // ),
          const SizedBox(height: 16),
          Text(
            _result,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
