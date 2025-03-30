import 'package:flutter/material.dart';
import 'package:testverygood/components/Plash.dart';
import 'package:testverygood/features/main_navbar.dart';
import 'package:testverygood/features/welcome/view/welcome_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PlashPages(),
    );
  }
}
