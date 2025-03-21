import 'package:flutter/material.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/features/settings/groupfriends/widgets/body_groups.dart';

class AddGroupPage extends StatelessWidget {
  const AddGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderA(title: 'Add group'),
      body: Padding(
        padding: EdgeInsets.zero,
        child: Expanded(
          child: BodyMain(),
        ),
      ),
    );
  }
}
