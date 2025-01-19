import 'package:flutter/material.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/feature/add_friends/components/body_friends.dart';

class AddFriendPage extends StatelessWidget {
  const AddFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
