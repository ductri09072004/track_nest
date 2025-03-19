import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GptService {
  static final String apiKey = dotenv.env['API_KEY'] ?? '';
  static const String endpoint = 'https://api.openai.com/v1/chat/completions';

  Future<Map<String, String>> extractBillInfo(String extractedText) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'temperature': 0.3,
        'max_tokens': 30,
        'messages': [
          {
            'role': 'system',
            'content': 'Bạn là một trợ lý AI chuyên trích xuất thông tin từ hóa đơn.'
                'Nhiệm vụ của bạn là phân tích nội dung hóa đơn và trả về JSON hợp lệ với định dạng sau: '
                '{"totalAmount": "900000", "date": "10/03/2024", "categories": "Eating"}. '
                'Nếu không tìm thấy thông tin hợp lệ, hãy trả về {"totalAmount": null, "date": null, "categories": null}. '
                'Hướng dẫn cụ thể: '
                '- "totalAmount" chỉ chứa số, không có dấu phân cách (VD: 900000, không phải 900.000 hay 900,000). '
                '- "date" chỉ có thể ở dạng dd/MM/yyyy (VD: 10/03/2024). '
                '- "categories" phải là một trong 9 loại sau: Eating, Entertainment, Shopping, Health, Housing, Education, Salary, Bonus, Saving. '
                '- Xác định danh mục dựa trên nội dung hóa đơn, ví dụ: '
                '  + Nếu có từ khóa "cơm", "bún", "phở", "nhà hàng", phân loại là "Eating". '
                '  + Nếu có từ khóa "rạp chiếu phim", "game", phân loại là "Entertainment". '
                '  + Nếu có từ khóa "quần áo", "giày dép", phân loại là "Shopping". '
                'Nếu không xác định được danh mục, trả về "categories": null.',
          },
          {'role': 'user', 'content': extractedText},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final gptResponse = data['choices'][0]['message']['content'];

      // Đảm bảo gptResponse không phải null và là một chuỗi
      if (gptResponse is String &&
          gptResponse.trim().startsWith('{') &&
          gptResponse.trim().endsWith('}')) {
        try {
          final parsedJson = jsonDecode(gptResponse) as Map<String, dynamic>;

          return {
            'totalAmount': parsedJson['totalAmount']?.toString() ??
                'No valid currency found',
            "date": parsedJson['date']?.toString() ?? 'No valid currency found',
            "categories":
                parsedJson['categories']?.toString() ?? 'No categories found',
          };
        } catch (e) {
          return {
            "totalAmount": 'No valid currency found',
            "date": 'No valid currency found',
          };
        }
      } else {
        return {
          'totalAmount': 'No valid currency found',
          'date': 'No valid currency found',
        };
      }
    } else {
      throw Exception('Lỗi GPT: ${response.body}');
    }
  }
}
