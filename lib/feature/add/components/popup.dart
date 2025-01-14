import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Đảm bảo thêm thư viện flutter_svg vào pubspec.yaml

class PopupPage extends StatelessWidget {
  final VoidCallback onFirstButton; // Sử dụng cho nút đầu tiên
  final VoidCallback onSecondButton; // Sử dụng cho nút thứ hai

  const PopupPage({
    Key? key,
    required this.onFirstButton,
    required this.onSecondButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Nút đầu tiên chiếm toàn bộ chiều ngang
                SizedBox(
                  width: double.infinity, // Chiếm toàn bộ chiều ngang
                  child: ElevatedButton(
                    onPressed: onFirstButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 65,
                      ),
                      elevation: 5,
                      // ignore: deprecated_member_use
                      shadowColor: Colors.black.withOpacity(1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'lib/assets/icon/popup_icon/camera_icon.svg',
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Take photo',
                          style: txtbtn,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14), // Thêm khoảng cách giữa 2 nút

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onSecondButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 65,
                      ), // Thêm padding cho nút
                      elevation: 5, // Đổ bóng
                      // ignore: deprecated_member_use
                      shadowColor: Colors.black.withOpacity(1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'lib/assets/icon/popup_icon/photo_icon.svg', // Đường dẫn đến icon cho nút thứ hai
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Choose from gallery',
                          style: txtbtn,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static const TextStyle txtbtn = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: 'Lato',
  );
}
