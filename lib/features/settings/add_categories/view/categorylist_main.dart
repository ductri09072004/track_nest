import 'package:flutter/material.dart';
import 'package:testverygood/components/HeaderA.dart';
import 'package:testverygood/features/settings/add_categories/components/body_listcate.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // Đổi màu nền ở đây
      appBar: HeaderA(title: 'Categories'),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: BodyMain(), // Loại bỏ Expanded vì không cần thiết
      ),
    );
  }
}
