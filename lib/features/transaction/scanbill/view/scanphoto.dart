import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:testverygood/components/component_app/HeaderA.dart';
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
        _extractedText = '$_selectedModel is scanning...'; // Cập nhật model AI
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

      // Gửi văn bản OCR đến GPT để lấy tổng tiền
      var gptResponse = await GptService().getTotalAmount(rawText);

      setState(
        () => _extractedText = gptResponse!,
      ); // Nếu null, _extractedText sẽ là null
    } catch (e) {
      setState(() => _extractedText = 'No valid amount found');
    } finally {
      await textRecognizer.close();
    }
  }

  Future<void> _nestAI(File imageFile) async {
    var result = await NestAI().processImage(imageFile);
    setState(() {
      _extractedText = result;
    });
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
              onModelSelected: _updateModel,
            )
          else
            BtnSuccess(
              extractedText: _extractedText,
              onRescan: _rescan,
              imageTransaction: _imageFile!.path,
            ),
        ],
      ),
    );
  }
}
