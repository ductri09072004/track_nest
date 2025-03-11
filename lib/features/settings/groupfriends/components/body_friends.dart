import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:testverygood/data/data_api/friend_list_api.dart';
import 'package:testverygood/features/settings/groupfriends/view/addgroup_main.dart';

class BodyMain extends StatefulWidget {
  const BodyMain({super.key});

  @override
  State<BodyMain> createState() => _BodyMainState();
}

class _BodyMainState extends State<BodyMain> {
  late Future<Map<String, List<String>>> _groupedFriendsFuture;

  @override
  void initState() {
    super.initState();
    _groupedFriendsFuture = _loadGroupedFriends();
  }

  Future<Map<String, List<String>>> _loadGroupedFriends() async {
    String? uuid = await loadUUID();
    List<Map<String, dynamic>> friends = await fetchData(uuid);

    // Nhóm các thành viên theo name_group
    Map<String, List<String>> groupedFriends = {};

    for (var friend in friends) {
      String groupName = friend['name_group'] as String;
      String memberName = friend['name_mem'] as String;

      if (!groupedFriends.containsKey(groupName)) {
        groupedFriends[groupName] = [];
      }
      groupedFriends[groupName]!.add(memberName);
    }

    return groupedFriends;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 16),
      child: Column(
        children: [
          // Danh sách nhóm bạn bè
          Expanded(
            child: FutureBuilder<Map<String, List<String>>>(
              future: _groupedFriendsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Lỗi tải dữ liệu: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Không có bạn bè nào.'));
                }

                Map<String, List<String>> groupedFriends = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: groupedFriends.entries.map((entry) {
                      String groupName = entry.key;
                      List<String> members = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('🌟 $groupName', style: txtcate),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            height: 2,
                            color: Colors.black,
                          ),
                          ...members.map((member) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(member, style: txtmem),
                              )),
                          const SizedBox(height: 20),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),

          // Nút thêm bạn bè (luôn cố định dưới cùng)
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
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
