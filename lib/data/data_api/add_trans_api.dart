import 'dart:convert';
import 'dart:io';
import 'dart:math';
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

  static String generateCateId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
          10, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
    );
  }

  static Future<bool> saveTransaction({
    required String? uuid,
    required String selectedCategory,
    required DateTime selectedDate,
    required String money,
    required String note,
    required String toFrom,
    required String type,
    File? imageFile,
  }) async {
    try {
      final url = Uri.parse('http://3.26.221.69:5000/api/transactions');
      String? imageUrl;

      if (imageFile != null) {
        imageUrl = await uploadImageToCloudinary(imageFile);
      }

      final transactionData = {
        'cate_id': selectedCategory,
        'date':
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
        'money': int.tryParse(money.replaceAll('.', '')) ?? 0,
        'note': note,
        'pic': imageUrl,
        'tofrom': toFrom,
        'trans_id': generateCateId(),
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
            'Lỗi khi lưu giao dịch: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      print('Lỗi: $e');
      return false;
    }
  }
}
