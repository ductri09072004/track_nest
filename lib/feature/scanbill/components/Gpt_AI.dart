import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GptService {
  static final String apiKey = dotenv.env['API_KEY'] ?? '';
  static const String endpoint = 'https://api.openai.com/v1/chat/completions';

  Future<String?> getTotalAmount(String extractedText) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'temperature': 0.3,
        'max_tokens': 10,
        'messages': [
          {
            'role': 'system',
            'content':
                'Chỉ trích xuất số tiền từ văn bản. Chỉ trả về số tiền tổng, Ví dụ: 900000 không phải 900,000 hay 900.000',
          },
          {'role': 'user', 'content': extractedText}
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final String? gptResponse =
          (data['choices'][0]['message']['content'] as String?)?.trim();

      // Nếu GPT trả về "null" thì đổi thành null trong Dart
      return gptResponse?.toLowerCase() == 'null' ? null : gptResponse;
    } else {
      throw Exception('Lỗi GPT: ${response.body}');
    }
  }
}
