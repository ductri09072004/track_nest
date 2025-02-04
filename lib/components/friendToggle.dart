import 'package:flutter/material.dart';

class FriendToggleList extends StatefulWidget {
  final List<String> options;
  final List<bool> initialToggleStates;
  final String? selectedOption; // Thêm biến selectedOption
  final Function(int, bool) onChanged; // Callback onChanged

  const FriendToggleList({
    Key? key,
    required this.options,
    required this.initialToggleStates,
    required this.onChanged, // Thêm tham số onChanged
    this.selectedOption,
  }) : super(key: key);

  @override
  _FriendToggleListState createState() => _FriendToggleListState();
}

class _FriendToggleListState extends State<FriendToggleList> {
  late List<bool> toggleStates;

  @override
  void initState() {
    super.initState();
    toggleStates = List.from(
        widget.initialToggleStates); // Khởi tạo trạng thái toggle từ bên ngoài
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.asMap().entries.map((entry) {
        final int index = entry.key;
        final String friend = entry.value;

        // Kiểm tra nếu người này là người đã chọn
        if (widget.selectedOption == friend) {
          return SizedBox.shrink(); // Không hiển thị người đã chọn
        }

        return Padding(
          padding:
              const EdgeInsets.only(bottom: 10.0), // Khoảng cách giữa các dòng
          child: Row(
            children: [
              Switch(
                value: toggleStates[index],
                onChanged: (newValue) {
                  setState(() {
                    toggleStates[index] =
                        newValue; // Cập nhật trạng thái toggle
                  });
                  widget.onChanged(
                      index, newValue); // Gọi callback khi trạng thái thay đổi
                },
              ),
              const SizedBox(width: 16),
              Text(friend,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  )), // Hiển thị tên bạn bè
              const Spacer(),
            ],
          ),
        );
      }).toList(),
    );
  }
}
