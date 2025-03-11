import 'package:flutter/material.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/features/settings/categories/widgets/body_addcate.dart';

class AddCateMain extends StatelessWidget {
  const AddCateMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HeaderA(title: 'Categories'),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Expanded(
          child: BodyMain(),
        ),
      ),
    );
  }
}
