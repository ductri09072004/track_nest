import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/feature/scanbill/components/btn_add.dart';
import 'package:testverygood/feature/scanbill/components/btn_success.dart';
import 'package:testverygood/feature/scanbill/components/Nest_AI.dart';

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
        _extractedText = 'Nest AI is scanning...';
      });
      await _extractText(_imageFile!);
    }
  }

  Future<void> _extractText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();

    try {
      final recognizedText = await textRecognizer.processImage(inputImage);
      String rawText = recognizedText.text;

      // Gửi văn bản OCR đến GPT để lấy tổng tiền
      String? gptResponse = await GptService().getTotalAmount(rawText);

      setState(
        () => _extractedText = gptResponse!,
      ); // Nếu null, _extractedText sẽ là null
    } catch (e) {
      setState(() => _extractedText = 'No valid amount found');
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
          if (_imageFile == null || _extractedText == 'No valid amount found')
            ImagePickerOptions(
              onPickImage: () => _pickImage(ImageSource.gallery),
              onPickCam: () => _pickImage(ImageSource.camera),
              showWarning: _imageFile != null,
            )
          else
            BtnSuccess(
              extractedText: _extractedText,
              onRescan: _rescan,
            ),
        ],
      ),
    );
  }
}
