import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryDetector {
  static final Map<String, List<String>> categories = {
    'Eating': [],
    'Entertainment': [],
    'Shopping': [],
    'Health': [],
    'Education': [],
  };

  static Future<void> updateCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('http://3.26.221.69:5000/api/language/$category'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is Map &&
            data.containsKey(category) &&
            data[category] is List) {
          categories[category] =
              List<String>.from(data[category] as List<dynamic>);
        } else {
          print('Dữ liệu API không hợp lệ cho danh mục $category.');
        }
      } else {
        print(
            'Lỗi khi lấy dữ liệu từ API cho danh mục $category: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi kết nối API cho danh mục $category: $e');
    }
  }

  static Future<String?> determineCategory(String text) async {
    // Cập nhật danh mục từ API trước khi kiểm tra

    await updateCategory('Shopping');
    await updateCategory('Entertainment');
    await updateCategory('Health');
    await updateCategory('Education');
    await updateCategory('Eating');

    for (var category in categories.keys) {
      for (var keyword in categories[category]!) {
        if (text.toLowerCase().contains(keyword)) {
          return category;
        }
      }
    }
    return null;
  }
}
