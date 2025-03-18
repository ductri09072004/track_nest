import 'package:flutter/material.dart';
import 'package:testverygood/components/button.dart';
import 'package:testverygood/data/data_api/friend_list_api.dart';
import 'package:testverygood/features/settings/groupfriends/app.dart';

class PopupGroupSelection extends StatefulWidget {
  final Function(String) onSelectGroup;

  const PopupGroupSelection({
    super.key,
    required this.onSelectGroup,
  });

  @override
  _PopupGroupSelectionState createState() => _PopupGroupSelectionState();
}

class _PopupGroupSelectionState extends State<PopupGroupSelection> {
  String? selectedGroup;
  List<String> groupNames = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadGroups();
  }

  Future<void> loadGroups() async {
    try {
      final uuid = await loadUUID();
      final data = await fetchData(uuid);
      setState(() {
        groupNames = data
            .map((group) => group['name_group'].toString())
            .toSet()
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Lỗi khi tải nhóm: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateToTargetPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FriendListPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Choose the group',
              style: TextStyle(fontSize: 20, fontFamily: 'Lato'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : groupNames.isEmpty
                      ? const Center(child: Text('Không có nhóm nào'))
                      : ListView.builder(
                          itemCount: groupNames.length,
                          itemBuilder: (context, index) {
                            return _buildGroupItem(groupNames[index]);
                          },
                        ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlineButton(
                    label: 'Add group',
                    onPressed: () {
                      navigateToTargetPage(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Button(
                    label: 'Apply',
                    onPressed: () {
                      if (selectedGroup != null) {
                        widget.onSelectGroup(selectedGroup!);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupItem(String name) {
    bool isSelected = selectedGroup == name;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGroup = name;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF013CBC)
              : Colors.transparent, // Đổi màu nền khi được chọn
          borderRadius: BorderRadius.circular(8), // Bo góc nhẹ
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal, // Đậm khi chọn
              ),
            ),
            Text(
              '(6 people)',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
