import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImagePickerOptions extends StatelessWidget {
  final VoidCallback onPickImage;
  final VoidCallback onPickCam;
  final bool showWarning; // Thêm tham số này

  const ImagePickerOptions({
    Key? key,
    required this.onPickImage,
    required this.onPickCam,
    this.showWarning = false, // Mặc định là false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showWarning) ...[
                // Kiểm tra nếu cần hiển thị cảnh báo
                const Text(
                  'Please select or take photos again !',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lato',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your photo is not in the correct format',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              _buildButton(
                text: 'Choose from gallery',
                iconPath: 'lib/assets/icon/OCR_icon/addpic.svg',
                onPressed: onPickImage,
              ),
              _buildButton(
                text: 'Take a picture',
                iconPath: 'lib/assets/icon/OCR_icon/addcam.svg',
                onPressed: onPickCam,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required String iconPath,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: onPressed,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(iconPath),
              const SizedBox(height: 8),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Lato',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
