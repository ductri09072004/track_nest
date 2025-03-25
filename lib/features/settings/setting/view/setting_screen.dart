import 'package:flutter/material.dart';
import 'package:testverygood/bootstrap.dart';
import 'package:testverygood/components/Header_main.dart';
import 'package:testverygood/features/settings/setting/view/body.dart';

class SettingPage extends StatefulWidget {
  final String? defaultType; // Thêm tham số mặc định

  const SettingPage({super.key, this.defaultType});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Future<String?> loadTypeId() async {
    return widget.defaultType ??
        storage.read(key: 'type_id'); // Dùng giá trị mock nếu có
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<String?>(
            future: loadTypeId(),
            builder: (context, snapshot) {
              String type = snapshot.data ?? 'default';
              return HeaderMain(
                title: 'Setting',
                showHorizontalList: false,
                showSearchAndCalendar: false,
                type: type,
                showtypeACC: true,
              );
            },
          ),
          const Expanded(child: BodyMain()),
        ],
      ),
    );
  }
}
