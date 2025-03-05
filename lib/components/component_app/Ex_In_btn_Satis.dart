import 'package:flutter/material.dart';

class ExInBtnStatis extends StatefulWidget {
  const ExInBtnStatis(
      {required this.labels, required this.onToggle, super.key});
  final List<String> labels;
  final ValueChanged<int> onToggle;

  @override
  _ExInBtnState createState() => _ExInBtnState();
}

class _ExInBtnState extends State<ExInBtnStatis> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(widget.labels.length, (index) {
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onToggle(index);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? const Color(0xFF013CBC)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: selectedIndex == index
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // Màu bóng
                            blurRadius: 4, // Độ mờ
                            spreadRadius: 1, // Độ lan rộng
                            offset: const Offset(
                              0,
                              3,
                            ), // Dịch chuyển bóng xuống dưới
                          ),
                        ]
                      : [], // Không có bóng nếu không được chọn
                ),
                child: Text(
                  widget.labels[index],
                  style: TextStyle(
                    color: selectedIndex == index
                        ? Colors.white
                        : const Color(0xFF808080),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
