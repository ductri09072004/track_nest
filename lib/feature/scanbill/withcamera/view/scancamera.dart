import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );

    await cameraController.initialize();
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Stack(
        children: [
          CameraPreview(cameraController), // Hiển thị hình ảnh từ camera
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: takePicture,
                child: const Text('Chụp ảnh'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> takePicture() async {
    try {
      final XFile picture = await cameraController.takePicture();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ảnh đã được chụp: ${picture.path}')),
      );
    } catch (e) {
      debugPrint('Lỗi khi chụp ảnh: $e');
    }
  }
}
