import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/assets/core/appcolor.dart';

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
          AppBar(
            backgroundColor: Colors.white,
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
                color: AppColor.black,
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
