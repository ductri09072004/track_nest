import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class NestAI {
  Future<String> processImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();

    try {
      final recognizedText = await textRecognizer.processImage(inputImage);

      // Regex chỉ lấy số có ít nhất 4 chữ số và có thể có đơn vị tiền tệ
      final regex =
          RegExp(r'(?<!\d)(\d{1,3}(?:,\d{3})*(?:\.\d+)?)(?=\s*(VND|đ)?)');

      var filteredLines = recognizedText.text
          .split('\n')
          .where(regex.hasMatch)
          .map((line) {
            final match = regex.firstMatch(line);
            if (match != null) {
              var cleanText = match.group(1)!;
              cleanText = cleanText.replaceAll(',', ''); // Xóa dấu phẩy

              // Bỏ qua nếu là số điện thoại (đủ 10 chữ số liên tục)
              if (RegExp(r'^\d{10}$').hasMatch(cleanText)) {
                return '';
              }

              return cleanText;
            }
            return '';
          })
          .where((line) => line.isNotEmpty)
          .toSet()
          .toList();

      if (filteredLines.isEmpty) return 'No valid currency found';

      var amounts = filteredLines
          .map((line) => double.tryParse(line) ?? 0)
          .where((num) => num >= 1000) // Chỉ lấy giá trị >= 1000 VND
          .toList();

      if (amounts.isEmpty) return 'No valid amount found';

      var maxAmount = amounts.reduce((a, b) => a > b ? a : b);

      return maxAmount.toStringAsFixed(0);
    } catch (e) {
      return 'An error occurred while processing: $e';
    } finally {
      await textRecognizer.close();
    }
  }
}
