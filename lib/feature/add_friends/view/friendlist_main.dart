import 'package:flutter/material.dart';
import 'package:testverygood/components/component_app/HeaderA.dart';
import 'package:testverygood/feature/add_friends/components/body_friends.dart';

class FriendListPage extends StatelessWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderA(title: 'Friends'),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Expanded(
          child: BodyMain(),
        ),
      ),
    );
  }
}
