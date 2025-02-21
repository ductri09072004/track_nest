import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class NestAI {
  Future<String> processImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();

    try {
      final recognizedText = await textRecognizer.processImage(inputImage);
      final regex = RegExp(r'[+-]?\d{1,3}(?:,\d{3})*(?:\.\d+)?\s*(VND|đ)?');

      List<String> filteredLines = recognizedText.text
          .split('\n')
          .where((line) => regex.hasMatch(line))
          .map((line) {
            final match = regex.firstMatch(line);
            if (match != null) {
              String cleanText = match.group(0)!;
              cleanText = cleanText.replaceAll(RegExp(r'\s*(VND|đ)'), '');
              return cleanText;
            }
            return '';
          })
          .where((line) => line.isNotEmpty)
          .toSet()
          .toList();

      if (filteredLines.isEmpty) return 'No valid text found';

      List<double> amounts = filteredLines
          .map((line) => double.tryParse(line.replaceAll(',', '')) ?? 0)
          .toList();

      List<double> positiveNumbers = amounts.where((num) => num > 0).toList();
      List<double> negativeNumbers = amounts.where((num) => num < 0).toList();

      double maxAmount = positiveNumbers.isEmpty
          ? 0
          : positiveNumbers.reduce((a, b) => a > b ? a : b);
      double totalNegative =
          negativeNumbers.fold(0, (sum, num) => sum + num.abs());

      double finalResult = maxAmount - totalNegative;

      return finalResult.toStringAsFixed(0);
    } catch (e) {
      return 'An error occurred while processing: $e';
    } finally {
      await textRecognizer.close();
    }
  }
}
