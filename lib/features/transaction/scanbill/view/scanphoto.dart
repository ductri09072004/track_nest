import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testverygood/features/transaction/scanbill/components/Nest_AI.dart';
import 'package:testverygood/features/transaction/scanbill/widgets/btn_add.dart';
import 'package:testverygood/features/transaction/scanbill/widgets/btn_success.dart';
import 'package:testverygood/features/transaction/scanbill/components/Gpt_AI.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _imageFile;
  String _extractedText = 'No content yet';
  String _selectedModel = 'Nest_AI';
  String _extractedDate = 'No cate';
  String _extractedCate = 'No cate';

  final ImagePicker _picker = ImagePicker();

  void _updateModel(String model) {
    setState(() {
      _selectedModel = model;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _extractedText = '$_selectedModel is scanning...';
      });

      if (_selectedModel == 'Nest_AI') {
        await _nestAI(_imageFile!);
      } else {
        await _gptAI(_imageFile!);
      }
    }
  }

  Future<void> _gptAI(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();

    try {
      final recognizedText = await textRecognizer.processImage(inputImage);
      var rawText = recognizedText.text;

      // Gửi văn bản OCR đến GPT để lấy tổng tiền và ngày tháng
      var gptResponse = await GptService().extractBillInfo(rawText);

      setState(() {
        _extractedText = gptResponse['totalAmount'] ?? 'No valid';
        _extractedDate = gptResponse['date'] ?? 'No valid date found';
        _extractedCate = gptResponse['categories'] ?? 'No valid cate found';
      });
    } catch (e) {
      setState(() {
        _extractedText = 'No valid amount found';
        _extractedDate = 'No valid date found';
        _extractedCate = 'No valid cate found';
      });
    } finally {
      await textRecognizer.close();
    }
  }

  Future<void> _nestAI(File imageFile) async {
    try {
      var result = await NestAI().processImage(imageFile);

      // Chỉ decode nếu result thực sự là chuỗi JSON hợp lệ
      Map<String, dynamic>? parsedResult;
      if (result is String) {
        try {
          parsedResult = jsonDecode(result) as Map<String, dynamic>;
        } catch (e) {
          parsedResult = null;
        }
      }

      // Kiểm tra dữ liệu hợp lệ trước khi setState
      if (parsedResult != null) {
        setState(() {
          _extractedText = parsedResult?['totalAmount']?.toString() ??
              'No valid amount found';
          _extractedDate =
              parsedResult?['date']?.toString() ?? 'No valid date found';
          _extractedCate =
              parsedResult?['categories']?.toString() ?? 'No valid cate found';
        });
      } else {
        setState(() {
          _extractedText = 'No valid amount found';
          _extractedDate = 'No valid date found';
          _extractedCate = 'No valid cate found';
        });
      }
    } catch (e) {
      setState(() {
        _extractedText = 'No valid amount found';
        _extractedDate = 'No valid date found';
        _extractedCate = 'No valid cate found';
      });
    }
  }

  void _rescan() {
    setState(() {
      _imageFile = null;
      _extractedText = 'No content yet';
      _extractedDate = 'No cate';
      _extractedCate = 'No cate';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: const Color(0xFF808080),
              child: _imageFile != null
                  ? InteractiveViewer(
                      minScale: 1,
                      maxScale: 5,
                      child: Image.file(
                        _imageFile!,
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
          if (_imageFile == null || _extractedText == 'No valid currency found')
            ImagePickerOptions(
              onPickImage: () => _pickImage(ImageSource.gallery),
              onPickCam: () => _pickImage(ImageSource.camera),
              showWarning: _imageFile != null,
              onModelSelected: _updateModel,
              selectedModel: _selectedModel,
            )
          else
            BtnSuccess(
              extractedText: _extractedText,
              onRescan: _rescan,
              imageTransaction: _imageFile!.path,
              extracteDate: _extractedDate,
              extractedCate: _extractedCate,
            ),
        ],
      ),
    );
  }
}
