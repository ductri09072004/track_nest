import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoriesText extends StatefulWidget {
  const CategoriesText({
    required this.onCategorySelected, super.key,
  });

  final Function(String) onCategorySelected;

  @override
  _CategoriesTextState createState() => _CategoriesTextState();
}

class _CategoriesTextState extends State<CategoriesText> {
  List<dynamic>? categoriesData;
  String errorMessage = '';
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    fetchCategoriesData();
  }

  Future<void> fetchCategoriesData() async {
    try {
      final response =
          await http.get(Uri.parse('http://3.26.221.69:5000/api/categories'));

      if (response.statusCode == 200) {
        final rawData = response.body;
        print('Raw Data từ API: $rawData');

        try {
          final data = json.decode(rawData);

          if (data is Map<String, dynamic>) {
            // Chuyển đổi Map thành List bằng cách lấy values
            final validCategories = data.values.where((category) {
              return category is Map<String, dynamic> &&
                  category.containsKey('name');
            }).toList();

            if (validCategories.isNotEmpty) {
              setState(() {
                categoriesData = validCategories;
                errorMessage = '';
              });
            } else {
              setState(() {
                errorMessage = 'API không có danh mục hợp lệ!';
              });
            }
          } else {
            setState(() {
              errorMessage = 'Dữ liệu API không phải là danh sách hoặc Map!';
            });
          }
        } catch (e) {
          setState(() {
            errorMessage = 'Lỗi khi phân tích JSON: $e';
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
          : categoriesData == null
              ? const Center(child: CircularProgressIndicator())
              : _buildCategoryList(),
    );
  }

  Widget _buildCategoryList() {
    if (categoriesData == null || categoriesData!.isEmpty) {
      return const Center(child: Text('Không có dữ liệu'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categoriesData!.map((category) {
          if (category is! Map<String, dynamic>) {
            return const SizedBox(); // Bỏ qua nếu dữ liệu không hợp lệ
          }

          final categoryName =
              (category['name'] ?? 'Không có dữ liệu').toString();
          final isSelected = selectedCategory == categoryName;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = categoryName;
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
                    '${category["icon"] ?? "Không có dữ liệu"}',
                    style: const TextStyle(fontSize: 36),
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
