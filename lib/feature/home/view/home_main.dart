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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Color(0xFFA561CA),
            toolbarHeight: 55,
            flexibleSpace: FlexibleSpaceBar(
              background: HeaderMain(
                showTitle: false,
              ),
            ),
          ),
          SliverFillRemaining(
            child: BodyMain(),
          ),
        ],
      ),
    );
  }
}
