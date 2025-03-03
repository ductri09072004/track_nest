import 'package:flutter/material.dart';
import 'package:testverygood/components/Header_main.dart';
import 'package:testverygood/feature/home/view/body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          HeaderMain(
            title: 'My Transactions',
          ), // Phần header
          Expanded(
            child: BodyMain(),
          ), // Phần nội dung chiếm phần còn lại của màn hình
        ],
      ),
    );
  }
}
