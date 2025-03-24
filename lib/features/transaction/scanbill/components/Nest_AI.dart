import 'dart:convert';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:testverygood/features/transaction/scanbill/components/Language_Nest.dart';

class NestAI {
  Future<String> processImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();

    try {
      final recognizedText = await textRecognizer.processImage(inputImage);
      final textContent = recognizedText.text;

      final moneyRegex = RegExp(
        r'(?<!\d)(\d{1,3}([,\. ]\d{3})*(\.\d+)?)(?=\s*(VND|VNĐ|đ)?)',
        caseSensitive: false,
      );

      final dateRegex = RegExp(
        r'(\b\d{1,2}[\/\-\.\s]\d{1,2}[\/\-\.\s]\d{2,4}\b)|'
        r'(\b\d{4}[\/\-\.\s]\d{1,2}[\/\-\.\s]\d{1,2}\b)|'
        r'(\b\d{1,2}\s(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[a-z]*\s\d{4}\b)',
        caseSensitive: false,
      );

      String formatDate(String date) {
        final dateRegex = RegExp(r'(\d{4})-(\d{2})-(\d{2})');

        if (dateRegex.hasMatch(date)) {
          final match = dateRegex.firstMatch(date);
          if (match != null) {
            String year = match.group(1)!;
            String month = match.group(2)!;
            String day = match.group(3)!;
            return '$day/$month/$year';
          }
        }
        return date; // Trả về ngày gốc nếu không đúng định dạng YYYY-MM-DD
      }

      List<String> moneyValues = textContent
          .split('\n')
          .where((line) => moneyRegex.hasMatch(line))
          .map((line) {
            final match = moneyRegex.firstMatch(line);
            if (match != null) {
              var cleanText = match.group(1)!;
              cleanText = cleanText.replaceAll(RegExp(r'[ ,\.]'), '');

              if (RegExp(r'^\d{10,13}$').hasMatch(cleanText)) return '';

              return cleanText;
            }
            return '';
          })
          .where((line) => line.isNotEmpty)
          .toSet()
          .toList();

      List<String> dateValues = textContent
          .split('\n')
          .where((line) => dateRegex.hasMatch(line))
          .map((line) => dateRegex.firstMatch(line)?.group(0) ?? '')
          .where((line) => line.isNotEmpty)
          .toSet()
          .toList();

      String? totalAmount = moneyValues.isNotEmpty
          ? moneyValues
              .map((e) => double.tryParse(e) ?? 0)
              .reduce((a, b) => a > b ? a : b)
              .toStringAsFixed(0)
          : null;

      String billDate =
          dateValues.isNotEmpty ? formatDate(dateValues.first) : 'null';

      String? categories = CategoryDetector.determineCategory(textContent);
      categories =
          (categories == null || categories.isEmpty) ? 'Bonus' : categories;

      return jsonEncode({
        'totalAmount': totalAmount,
        'date': billDate == 'null' ? null : billDate,
        'categories': categories,
      });
    } catch (e) {
      return jsonEncode({
        'totalAmount': null,
        'date': null,
        'categories': null,
        'error': 'An error occurred: $e',
      });
    } finally {
      await textRecognizer.close();
    }
  }
}
