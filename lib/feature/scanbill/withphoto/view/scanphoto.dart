import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _imageFile;
  String _extractedText = 'Chưa có nội dung';

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
    try {
      final extractedText = await FlutterTesseractOcr.extractText(
        imageFile.path,
        language: 'vie',
        args: {
          'tessdata': 'lib/assets/tessdata/', // Đảm bảo đúng đường dẫn
        },
      );
      setState(() {
        _extractedText =
            extractedText.isEmpty ? 'Không tìm thấy văn bản' : extractedText;
      });
    } catch (e) {
      setState(() {
        _extractedText = 'Có lỗi xảy ra khi xử lý: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn ảnh và quét văn bản'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_imageFile != null)
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Chưa có ảnh nào được chọn'),
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Kết quả trích xuất văn bản:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _extractedText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo),
              label: const Text('Chọn từ thư viện'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera),
              label: const Text('Chụp ảnh'),
            ),
          ],
        ),
      ),
    );
  }
}
