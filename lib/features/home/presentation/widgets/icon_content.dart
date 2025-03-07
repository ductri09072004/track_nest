import 'package:flutter/material.dart';
import 'package:testverygood/data/data_api/icon_data.dart';

class IconDisplayScreen extends StatefulWidget {

  const IconDisplayScreen({required this.cateId, super.key});
  final String cateId;

  @override
  _IconDisplayScreenState createState() => _IconDisplayScreenState();
}

class _IconDisplayScreenState extends State<IconDisplayScreen> {
  final DataService _dataService = DataService();
  String? uuid;
  List<Map<String, dynamic>> icons = [];
  String errorMessage = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final storedUUID = await _dataService.loadUUID();
      if (storedUUID != null) {
        if (mounted) {
          setState(() {
            uuid = storedUUID;
          });
        }

        final fetchedIcons = await _dataService.fetchDataIcon(storedUUID);

        if (mounted) {
          setState(() {
            icons = fetchedIcons;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = 'Lỗi khi tải dữ liệu: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final matchingIcon = icons.firstWhere(
      (icon) => icon['name'] == widget.cateId,
      orElse: () => {'icon': ''},
    );

    return Text(
      matchingIcon['icon'] as String,
      style: const TextStyle(fontSize: 30),
    );
  }
}
