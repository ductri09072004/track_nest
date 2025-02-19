import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/feature/scanbill/components/btn_add.dart';
import 'package:testverygood/feature/scanbill/components/btn_success.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _imageFile;
  String _extractedText = 'No content yet';

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _extractedText = 'Đang xử lý...';
      });
      // Thực hiện OCR
      await _extractText(_imageFile!);
    }
  }

  Future<void> _extractText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();

    try {
      final recognizedText = await textRecognizer.processImage(inputImage);

      final regex = RegExp(
          r'[+-]?\d{1,3}(?:,\d{3})*(?:\.\d+)?\s*(VND|đ)?'); // Bao gồm cả số âm

      List<String> filteredLines = recognizedText.text
          .split('\n')
          .where((line) => regex.hasMatch(line))
          .map((line) {
            final match = regex.firstMatch(line);
            if (match != null) {
              String cleanText = match.group(0)!;
              cleanText = cleanText.replaceAll(
                RegExp(r'\s*(VND|đ)'),
                '',
              ); // Xóa đơn vị tiền tệ
              return cleanText;
            }
            return '';
          })
          .where((line) => line.isNotEmpty)
          .toSet()
          .toList();

      if (filteredLines.isEmpty) {
        setState(() {
          _extractedText = 'No valid text found';
        });
        return;
      }

      // Chuyển đổi danh sách thành số
      List<double> amounts = filteredLines
          .map((line) => double.tryParse(line.replaceAll(',', '')) ?? 0)
          .toList();

      // Tách số dương và số âm
      List<double> positiveNumbers = amounts.where((num) => num > 0).toList();
      List<double> negativeNumbers = amounts.where((num) => num < 0).toList();

      double maxAmount = positiveNumbers.isEmpty
          ? 0
          : positiveNumbers.reduce((a, b) => a > b ? a : b);
      double totalNegative =
          negativeNumbers.fold(0, (sum, num) => sum + num.abs());

      double finalResult = maxAmount - totalNegative;

      setState(() {
        _extractedText = finalResult.toStringAsFixed(0);
      });
    } catch (e) {
      setState(() {
        _extractedText = 'An error occurred while processing: $e';
      });
    } finally {
      await textRecognizer.close();
    }
  }

  void _rescan() {
    setState(() {
      _imageFile = null;
      _extractedText = 'No content yet';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderA(title: 'Scan the Text'),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: const Color(0xFF808080),
              child: _imageFile != null
                  ? InteractiveViewer(
                      minScale: 1,
                      maxScale: 5,
                      child: Image.file(
                        _imageFile!,
                        fit:
                            BoxFit.cover, // Giúp ảnh lấp đầy toàn bộ khung hình
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                  : const Center(
                      child: Text(
                        'Current no available image',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Lato',
                          color: Colors.white,
                        ),
                      ),
                    ),
            ),
          ),
          if (_imageFile == null ||
              _extractedText == 'No valid text found' ||
              _extractedText!.trim().isEmpty)
            ImagePickerOptions(
              onPickImage: () => _pickImage(ImageSource.gallery),
              onPickCam: () => _pickImage(ImageSource.camera),
              showWarning: _imageFile != null,
            )
          else
            BtnSuccess(
              extractedText:
                  _extractedText, // Truyền extractedText vào BtnSuccess
              onRescan: _rescan,
            ),
        ],
      ),
    );
  }
}
