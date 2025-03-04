import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CategoriesText extends StatefulWidget {
  const CategoriesText({
    super.key,
    // required this.isExpense,
    required this.onCategorySelected,
  });

  // final bool isExpense;
  // ignore: inference_failure_on_function_return_type
  final Function(String) onCategorySelected;

  @override
  _CategoriesTextState createState() => _CategoriesTextState();
}

class _CategoriesTextState extends State<CategoriesText> {
  final storage = const FlutterSecureStorage();
  String? uuid;
  List<Map<String, dynamic>> categories = [];
  String errorMessage = '';
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadUUID();
  }

  // @override
  // void didUpdateWidget(covariant CategoriesText oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.isExpense != widget.isExpense) {
  //     fetchCustomerData();
  //   }
  // }

  Future<void> _loadUUID() async {
    var storedUUID = await storage.read(key: 'unique_id');
    setState(() {
      uuid = storedUUID;
    });

    if (uuid != null) {
      await fetchCustomerData();
    } else {
      setState(() {
        errorMessage = 'Không tìm thấy UUID!';
      });
    }
  }

  Future<void> fetchCustomerData() async {
    try {
      final response =
          await http.get(Uri.parse('http://3.26.221.69:5000/api/categories'));

      if (response.statusCode == 200) {
        final rawData = response.body;
        print('Raw Data từ API: $rawData');

        // final Map<String, dynamic> data = json.decode(rawData);
        final data = json.decode(rawData) as Map<String, dynamic>;
        // Lọc danh mục theo user_id và type (expense/income)
        final filteredCategories = data.entries
            .where(
              (entry) =>
                  entry.value['user_id'] == uuid,
                  // &&
                  // entry.value['type'] ==
                      // (widget.isExpense ? 'expense' : 'income'),
            )
            .map((entry) => entry.value as Map<String, dynamic>)
            .toList();

        setState(() {
          categories = filteredCategories;
          selectedCategory = null; // Reset lựa chọn khi đổi type
        });
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
          : categories.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : _buildCategoryList(),
    );
  }

  Widget _buildCategoryList() {
    if (categories.isEmpty) {
      return const Center(child: Text('Không có dữ liệu'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categories.map((category) {
          final categoryName = category['name'] ?? 'Không có dữ liệu';
          final isSelected = selectedCategory == categoryName;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = categoryName;
              });
              widget.onCategorySelected(categoryName);
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
                    '${category["icon"] ?? "❓"}',
                    style: const TextStyle(fontSize: 36),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    categoryName as String,
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
