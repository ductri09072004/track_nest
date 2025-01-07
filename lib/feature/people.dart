import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Trang Bạn Bè',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
