import 'package:flutter/material.dart';
import 'package:testverygood/components/component_app/Plash.dart';

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
