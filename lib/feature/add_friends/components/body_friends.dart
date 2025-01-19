import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/feature/add_friends/view/addgroup_main.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Chiếm toàn bộ chiều rộng màn hình
      height: MediaQuery.of(context)
          .size
          .height, // Chiếm toàn bộ chiều cao màn hình

      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Đoạn text "Best friend"
          const Text('Best friend', style: txtcate),

          // Đoạn đường kẻ
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: 2, // Độ dày của đường kẻ
            color: Colors.black, // Màu sắc của đường kẻ
          ),

          // Các đoạn text tiếp theo
          const Text('Duc Tri (You)', style: txtmem),
          const SizedBox(height: 10),
          const Text('MTri', style: txtmem),
          const SizedBox(height: 10),
          const Text('Phuc', style: txtmem),

          const Spacer(),
          Center(
            child: GestureDetector(
              onTap: () {
                // Chuyển đến màn hình khác (ví dụ AddFriendPage)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddGroupPage()),
                );
              },
              child: SvgPicture.asset(
                'lib/assets/icon/active_navbar/addA_icon.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const TextStyle txtcate = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Lato',
  );

  static const TextStyle txtmem = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontFamily: 'Lato_Regular',
  );
}
