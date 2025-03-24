import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testverygood/bootstrap.dart';
import 'package:testverygood/features/settings/categories/view/categorylist_main.dart';
import 'package:testverygood/features/settings/groupfriends/app.dart';
import 'package:testverygood/features/settings/restore_acc/view/Restore_main.dart';
import 'package:testverygood/features/settings/subcription/app.dart';
import 'package:testverygood/features/settings/subcription/view/link_email.dart';

class BodyMain extends StatelessWidget {
  const BodyMain({super.key});

  Future<String?> loadTypeId() async {
    return storage.read(key: 'type_id');
  }

  void navigateToTargetPage(BuildContext context, Widget targetPage) async {
    String? typeId = await storage.read(key: 'type_id');

    if (typeId == 'free') {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UpgradeAccountPage()),
      );
    } else if (typeId == 'premium') {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => targetPage),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xFFFDFDFD),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 20, right: 20, left: 20,),
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
                          const SizedBox(width: 10),
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
                      navigateToTargetPage(context, const CategoryListPage());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'lib/assets/icon/setting_icon/categories.svg',
                          ),
                          const SizedBox(width: 10),
                          const Text('Categories', style: txtpeo),
                          const Spacer(),
                          Text('For premium', style: txtpro),
                          SizedBox(width: 10),
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
                      navigateToTargetPage(context, LinkEmail());
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text('Link Email', style: txtpeo),
                          Spacer(),
                          Text('For premium', style: txtpro),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios,
                              size: 20, color: Colors.black),
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
                          builder: (context) => const UpgradeAccountPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'lib/assets/icon/setting_icon/premium_icon.svg',
                          ),
                          const SizedBox(width: 10),
                          const Text('Subscription', style: txtpeo),
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
                          builder: (context) => const RestoreAcc(),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.restore, // Biểu tượng khôi phục
                            size: 24,
                            color: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text('Restore Account', style: txtpeo),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,
                              size: 20, color: Colors.black),
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
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'v1.0.0',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static const TextStyle txtpeo =
      TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Lato');
  static const TextStyle txtpro =
      TextStyle(color: Colors.green, fontSize: 14, fontFamily: 'Lato');
}
