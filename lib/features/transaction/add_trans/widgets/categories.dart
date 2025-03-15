import 'package:flutter/material.dart';
import 'package:testverygood/data/data_api/category_trans_data_api.dart';

class CategoriesText extends StatefulWidget {
  const CategoriesText({
    super.key,
    required this.isExpense,
    required this.onCategorySelected,
  });

  final bool isExpense;
  final Function(String) onCategorySelected;

  @override
  _CategoriesTextState createState() => _CategoriesTextState();
}

class _CategoriesTextState extends State<CategoriesText> {
  final CategoryService _categoryService = CategoryService();

  String? uuid;
  List<Map<String, dynamic>> categories = [];
  String errorMessage = '';
  String? selectedCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void didUpdateWidget(covariant CategoriesText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpense != widget.isExpense) {
      _fetchData();
    }
  }

  Future<void> _initializeData() async {
    try {
      uuid = await _categoryService.loadUUID();
      if (uuid != null) {
        await _fetchData();
      } else {
        setState(() {
          errorMessage = 'Không tìm thấy UUID!';
        });
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

  Future<void> _fetchData() async {
    try {
      final data = await _categoryService.fetchCustomerData(
        uuid: uuid,
        isExpense: widget.isExpense,
      );
      setState(() {
        categories = data;
        selectedCategory = null;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('categories_text'),
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
