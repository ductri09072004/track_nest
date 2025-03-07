import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/features/settings/add_friends/view/addgroup_main.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Chiếm toàn bộ chiều rộng màn hình
      height: MediaQuery.of(context)
          .size
          .height, // Chiếm toàn bộ chiều cao màn hình
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      child: Column(
        children: [
          // Danh sách có thể cuộn
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Khối Best Friend 1
                  const Text('🌟 Best friend', style: txtcate),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    height: 2,
                    color: Colors.black,
                  ),
                  const Text('Duc Tri (You)', style: txtmem),
                  const SizedBox(height: 10),
                  const Text('MTri', style: txtmem),
                  const SizedBox(height: 10),
                  const Text('Phuc', style: txtmem),

                  const SizedBox(height: 20),

                  // Khối Best Friend 2
                  const Text('🌟 Best friend', style: txtcate),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    height: 2,
                    color: Colors.black,
                  ),
                  const Text('Duc Tri (You)', style: txtmem),
                  const SizedBox(height: 10),
                  const Text('MTri', style: txtmem),
                  const SizedBox(height: 10),
                  const Text('Phuc', style: txtmem),

                  const SizedBox(height: 20),

                  const Text('🌟 Best friend', style: txtcate),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    height: 2,
                    color: Colors.black,
                  ),
                  const Text('Duc Tri (You)', style: txtmem),
                  const SizedBox(height: 10),
                  const Text('MTri', style: txtmem),
                  const SizedBox(height: 10),
                  const Text('Phuc', style: txtmem),

                  const SizedBox(height: 20),

                  const Text('🌟 Best friend', style: txtcate),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    height: 2,
                    color: Colors.black,
                  ),
                  const Text('Duc Tri (You)', style: txtmem),
                  const SizedBox(height: 10),
                  const Text('MTri', style: txtmem),
                  const SizedBox(height: 10),
                  const Text('Phuc', style: txtmem),

                  const SizedBox(height: 20),

                  const Text('🌟 Best friend', style: txtcate),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    height: 2,
                    color: Colors.black,
                  ),
                  const Text('Duc Tri (You)', style: txtmem),
                  const SizedBox(height: 10),
                  const Text('MTri', style: txtmem),
                  const SizedBox(height: 10),
                  const Text('Phuc', style: txtmem),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Nút thêm bạn bè (luôn cố định dưới cùng)
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                // Chuyển đến màn hình AddGroupPage
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
