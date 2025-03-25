import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  static Future<String?> uploadImageToCloudinary(File imageFile) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/dcdaz0dzb/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = 'blueduck'
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = jsonDecode(await response.stream.bytesToString())
          as Map<String, dynamic>;
      return responseData['secure_url'] as String?;
    } else {
      print('Lỗi tải ảnh lên Cloudinary: ${response.reasonPhrase}');
      return null;
    }
  }

  static String generateTransId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        10,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );
  }

  static Future<bool> saveTransaction({
    required String uuid,
    required String selectedCategory,
    required DateTime selectedDate,
    required String money,
    required String note,
    required String toFrom,
    required String type,
    // File? imageFile,
    http.Client? client,
  }) async {
    client ??= http.Client();

    if (uuid.isEmpty) {
      throw Exception('UUID không được rỗng');
    }
    if (selectedCategory.isEmpty) {
      throw Exception('Category không được rỗng');
    }
    if (money.isEmpty) {
      throw Exception('money không được rỗng');
    }
    if (type.isEmpty) {
      throw Exception('type không được rỗng');
    }
    final moneyValue = int.tryParse(money.replaceAll('.', ''));
    if (moneyValue! <= 0) {
      throw Exception('Số tiền phải lớn hơn 0');
    }
    if (money.contains(RegExp('[a-zA-Z]'))) {
      throw Exception('Số tiền không được chứa chữ cái');
    }

    try {
      final url = Uri.parse('http://3.26.221.69:5000/api/transactions');
      String? imageUrl;

      // if (imageFile != null) {
      //   imageUrl = await uploadImageToCloudinary(imageFile);
      // }

      final transactionData = {
        'cate_id': selectedCategory,
        'date':
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
        'money': int.tryParse(money.replaceAll('.', '')) ?? 0,
        'note': note,
        'pic': imageUrl,
        'tofrom': toFrom,
        'trans_id': generateTransId(),
        'type': type,
        'user_id': uuid,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(transactionData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Giao dịch đã lưu: ${response.body}');
        return true;
      } else {
        print(
          'Lỗi khi lưu giao dịch: ${response.statusCode} - ${response.body}',
        );
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateTransaction({
    required String transactionId,
    required int money,
    required String note,
    required String toFrom,
    required DateTime selectedDate,
    http.Client? client,
  }) async {
    client ??= http.Client();

    if (transactionId.isEmpty) {
      throw Exception('ID giao dịch không được rỗng');
    }
    if (money <= 0) {
      throw Exception('Số tiền phải lớn hơn 0');
    }

    final url =
        Uri.parse('http://3.26.221.69:5000/api/transactions/$transactionId');

    final updatedData = <String, dynamic>{
      'money': money,
      'note': note,
      'tofrom': toFrom,
      'date': '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
    };

    try {
      final response = await client.put(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteTransaction({
    required String transactionId,
    http.Client? client,
  }) async {
    client ??= http.Client();
    if (transactionId.isEmpty) {
      throw Exception('ID giao dịch không được rỗng');
    }

    final url =
        Uri.parse('http://3.26.221.69:5000/api/transactions/$transactionId');

    try {
      final response = await client.delete(url);
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
