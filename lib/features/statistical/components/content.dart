import 'package:flutter/material.dart';
import 'package:testverygood/data/data_api/content_barchart_data.dart';

class Content extends StatefulWidget {
  const Content({required this.tabType, super.key});
  final String tabType;

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  List<ExpenseData> data = [];
  bool isLoading = true;
  String errorMessage = '';
  String? uuid;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      final storedUUID = await loadUUID();
      if (storedUUID == null) {
        setState(() {
          errorMessage = 'Không tìm thấy UUID';
          isLoading = false;
        });
        return;
      }

      uuid = storedUUID;
      final transactions = await fetchData(uuid!, widget.tabType);
      setState(() {
        data = processTransactions(transactions);
        isLoading = false;
      });
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
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage,
                      style: const TextStyle(color: Colors.red)))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data
                      .map(
                        (expense) => Column(
                          children: [
                            buildDateSection(
                              expense.percent,
                              expense.title,
                              expense.price,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      )
                      .toList(),
                ),
    );
  }

  Widget buildDateSection(String percent, String title, String price) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF537FF1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(percent, style: perText),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: titleText),
          ],
        ),
        const Spacer(),
        Text(price, style: titlePrice),
      ],
    );
  }

  static const TextStyle titleText = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );

  static const TextStyle perText = TextStyle(
    fontSize: 16,
    fontFamily: 'Lato_Regular',
    color: Color(0xFFFFFFFF),
  );

  static const TextStyle titlePrice = TextStyle(
    fontSize: 18,
    fontFamily: 'Lato',
  );
}
