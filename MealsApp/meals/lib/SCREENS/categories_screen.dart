import 'package:flutter/material.dart';
import 'package:meals/DATA/dummy_data.dart';
import '../WIDGETS/category_item_widget.dart';

class CategoryScreen extends StatelessWidget {

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 60,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2),
        children: DUMMY_CATEGORIES
            .map((e) =>
                CategoryItem(id: e.id, title: e.title, color: e.color))
            .toList(),
      ),
    );
  }
}
