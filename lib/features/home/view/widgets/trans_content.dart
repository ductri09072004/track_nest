import 'package:flutter/material.dart';
import 'package:testverygood/data/data_api/home_data.dart';
import 'package:testverygood/features/transactions/edit_transactions/view/edit_main.dart';
import 'package:testverygood/features/home/domain/models/transaction_model.dart';
import 'package:testverygood/features/home/domain/services/transaction_service.dart';
import 'package:testverygood/features/home/view/widgets/icon_content.dart';

class ExpContent extends StatefulWidget {
  const ExpContent({super.key});

  @override
  _ExpContentState createState() => _ExpContentState();
}

class _ExpContentState extends State<ExpContent> {
  String? uuid;
  late Future<List<TransactionModel>> futureTransactions;
  final TransactionService transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final storedUUID = await loadUUID();
    setState(() {
      uuid = storedUUID;
      futureTransactions = transactionService.fetchTransactions(uuid);
    });
  }

  void navigateToDetailPage(BuildContext context, String transId, Widget icon) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMain(transid: transId, icon: icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (uuid == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: FutureBuilder<List<TransactionModel>>(
        future: futureTransactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('There are no transactions'));
          }

          final transactions = snapshot.data!;
          transactions
              .sort((a, b) => _parseDate(b.date).compareTo(_parseDate(a.date)));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: transactions.map((transaction) {
              return buildExpenseRow(
                IconDisplayScreen(cateId: transaction.cateId),
                transaction.cateId,
                '${transaction.type == 'expense' ? '-' : '+'}${formatCurrency(transaction.amount)} VND',
                transaction.type == 'expense',
                transaction.date,
                transaction.transId,
              );
            }).toList(),
          );
        },
      ),
    );
  }

  DateTime _parseDate(String dateString) {
    final parts = dateString.split('/');
    if (parts.length < 3) return DateTime(2000, 1, 1);
    return DateTime(
        int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]),);
  }

  String formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  Widget buildExpenseRow(Widget iconWidget, String title, String price,
      bool isRed, String date, String trans,) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          navigateToDetailPage(context, trans, iconWidget);
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFDBEAFE),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF1F62F2)),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              iconWidget,
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: titleicon),
                  const SizedBox(height: 4),
                  Text(date, style: titledate),
                ],
              ),
              const Spacer(),
              Text(price, style: isRed ? titleprice : titleprice2),
            ],
          ),
        ),
      ),
    );
  }

  static const TextStyle titleicon = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
  static const TextStyle titledate = TextStyle(
    fontSize: 12,
    fontFamily: 'Lato',
    color: Color(0xFF808080),
  );
  static const TextStyle titleprice = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato',
    color: Color(0xFFF44336),
  );
  static const TextStyle titleprice2 = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato',
    color: Color(0xFF5CB338),
  );
}
