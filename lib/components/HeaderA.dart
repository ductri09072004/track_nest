import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderA extends StatelessWidget implements PreferredSizeWidget {
  const HeaderA({
    super.key,
    required this.title,
    this.onBack,
  });
  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color(0xFFA561CA), // Màu nền tím
            ),
          ),
          Positioned.fill(
            child: SvgPicture.asset(
              'lib/assets/svg/Background.svg',
              fit: BoxFit.cover,
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // Xóa bóng của AppBar
            leading: IconButton(
              icon: SvgPicture.asset(
                'lib/assets/icon/components_icon/back_icon.svg',
              ),
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            ),
            centerTitle: true, // Căn giữa tiêu đề
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Lato',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
