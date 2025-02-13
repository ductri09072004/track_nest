import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testverygood/feature/add_categories/view/categorylist_main.dart';
import 'package:testverygood/feature/add_friends/app.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height / 5,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 110, right: 20, left: 20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FriendListPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'lib/assets/icon/setting_icon/people.svg',
                          ),
                          const SizedBox(width: 10,), // Khoảng cách giữa icon và text
                          const Text('Group Friend', style: txtpeo),
                          const Spacer(),
                          SvgPicture.asset(
                            'lib/assets/icon/setting_icon/next.svg',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CategoryListPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'lib/assets/icon/setting_icon/categories.svg',
                          ),
                          const SizedBox(
                            width: 10,
                          ), // Khoảng cách giữa icon và text
                          const Text('Categories', style: txtpeo),
                          const Spacer(),
                          SvgPicture.asset(
                            'lib/assets/icon/setting_icon/next.svg',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 20), // Khoảng cách từ text đến đáy
                child: Text(
                  'v1.0.0',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  static const TextStyle txtpeo =
      TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Lato');
}
