import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({super.key});

  @override
  _BalanceCardState createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  String? uuid;
  final storage = const FlutterSecureStorage();
  int expense = 0; // Tổng chi tiêu
  int income = 0; // Tổng thu nhập
  bool isLoading = true; // Trạng thái tải dữ liệu

  @override
  void initState() {
    super.initState();
    _loadUUID();
  }

  Future<void> _loadUUID() async {
    final storedUUID = await storage.read(key: 'unique_id');
    setState(() {
      uuid = storedUUID;
    });

    if (uuid != null) {
      await fetchData();
    }
  }

  Future<void> fetchData() async {
    if (uuid == null) return;

    try {
      final response =
          await http.get(Uri.parse('http://3.26.221.69:5000/api/transactions'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final transactions = data.entries
            .map((entry) => entry.value as Map<String, dynamic>)
            .toList();

        // Lọc giao dịch của user hiện tại
        final userTransactions = transactions.where((t) {
          return t['user_id'] == uuid;
        }).toList();

        // Tính tổng Expense và Income
        var totalExpense = 0;
        var totalIncome = 0;

        for (var transaction in userTransactions) {
          int amount = int.tryParse(transaction['money'].toString()) ?? 0;

          if (transaction['type'] == 'expense') {
            totalExpense += amount;
          } else if (transaction['type'] == 'income') {
            totalIncome += amount;
          }
        }

        setState(() {
          expense = totalExpense;
          income = totalIncome;
          isLoading = false; // Kết thúc trạng thái tải
        });
      } else {
        throw Exception('Không thể tải dữ liệu');
      }
    } catch (e) {
      setState(() => isLoading = false);
      print('Lỗi khi tải dữ liệu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFE12179), Color(0xFF013CBC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Total balance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Lato',
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(income - expense).toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Lato',
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'VND',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Lato',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildBalanceItem(
                      icon: Icons.arrow_upward,
                      color: Colors.red,
                      title: 'Expenses',
                      amount: expense.toStringAsFixed(0),
                    ),
                    _buildBalanceItem(
                      icon: Icons.arrow_downward,
                      color: Colors.green,
                      title: 'Income',
                      amount: income.toStringAsFixed(0),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildBalanceItem({
    required IconData icon,
    required Color color,
    required String title,
    required String amount,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              '$amount VND',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
