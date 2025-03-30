import 'package:flutter/material.dart';
import 'package:testverygood/bootstrap.dart';
import 'package:testverygood/components/Header_main.dart';
import 'package:testverygood/features/settings/setting/view/body.dart';

class SettingPage extends StatefulWidget {
  final String? defaultType;

  const SettingPage({super.key, this.defaultType});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late Future<String?> _typeFuture;

  @override
  void initState() {
    super.initState();
    _typeFuture = fetchAndSaveTypeId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder<String?>(
            future: _typeFuture,
            builder: (context, snapshot) {
              String type = snapshot.data ?? 'free';
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
