import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testverygood/components/data_api/balence_api.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({super.key});

  @override
  _BalanceCardState createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  String? uuid;
  int expense = 0;
  int income = 0;
  bool isLoading = true;
  bool isBalanceVisible = true;
  String errorMessage = '';

  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      uuid = await dataService.loadUUID();
      if (uuid != null) {
        final data = await dataService.fetchData(uuid);
        if (mounted) {
          setState(() {
            expense = data['expense']!;
            income = data['income']!;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Lỗi khi tải dữ liệu: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total balance',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Lato'),
                    ),
                    IconButton(
                      icon: Icon(
                        isBalanceVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isBalanceVisible = !isBalanceVisible;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isBalanceVisible
                          ? NumberFormat('#,###', 'vi_VN')
                              .format(income - expense)
                          : '******',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: 'Lato'),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'VND',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontFamily: 'Lato'),
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
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1)
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 8),
            Text(title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text(
              isBalanceVisible
                  ? NumberFormat('#,###', 'vi_VN').format(int.parse(amount))
                  : '******',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
