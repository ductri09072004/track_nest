import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriesText extends StatefulWidget {
  // Nhận callback

  const CategoriesText({
    Key? key,
    required this.isExpense,
    required this.onCategorySelected, // Bắt buộc phải có
  }) : super(key: key);
  final bool isExpense;

  final Function(String) onCategorySelected;

  @override
  _CategoriesTextState createState() => _CategoriesTextState();
}

class _CategoriesTextState extends State<CategoriesText> {
  Map<String, dynamic>? customerData;
  String errorMessage = '';
  String? selectedCategory; // Biến lưu mục đã chọn

  @override
  void initState() {
    super.initState();
    fetchCustomerData();
  }

  Future<void> fetchCustomerData() async {
    try {
      final response =
          await http.get(Uri.parse('http://3.26.221.69:5000/api/categories'));

      if (response.statusCode == 200) {
        final rawData = response.body;
        print('Raw Data từ API: $rawData');

        final data = json.decode(rawData);

        if (data is List && data.isNotEmpty) {
          setState(() {
            customerData = data.first as Map<String, dynamic>;
          });
        } else if (data is Map<String, dynamic>) {
          setState(() {
            customerData = data;
          });
        } else {
          setState(() {
            errorMessage = 'Dữ liệu từ API không đúng định dạng!';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Lỗi kết nối API: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi khi tải dữ liệu: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: errorMessage.isNotEmpty
          ? Center(
              child:
                  Text(errorMessage, style: const TextStyle(color: Colors.red)),
            )
          : customerData == null
              ? const Center(child: CircularProgressIndicator())
              : _buildUserList(),
    );
  }

  Widget _buildUserList() {
    final userList = customerData?['user1'];

    if (userList == null) {
      return const Center(child: Text('Không có dữ liệu'));
    }

    if (userList is! List) {
      return const Center(
        child: Text('Lỗi: Dữ liệu không phải danh sách'),
      );
    }
    final filteredList = userList
        .where(
          (user) =>
              user is Map<String, dynamic> &&
              user['type'] == (widget.isExpense ? 'expense' : 'income'),
        )
        .toList();

    if (filteredList.isEmpty) {
      return const Center(child: Text('Không có mục nào thuộc "expense"'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: filteredList.map((user) {
          final categoryName = (user['name'] ?? 'Không có dữ liệu').toString();
          final isSelected = selectedCategory == categoryName;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = categoryName; // Gán giá trị đã chọn
              });
              widget.onCategorySelected(categoryName);
              print('Bạn đã chọn: $categoryName');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.blue.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '${user["icon"] ?? "Không có dữ liệu"}',
                    style: const TextStyle(
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    categoryName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
