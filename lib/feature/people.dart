import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({Key? key}) : super(key: key);

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
