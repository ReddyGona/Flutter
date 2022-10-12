// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../SCREENS/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  
  const CategoryItem({ required this.id, required this.title, required this.color});

  void selectCategory(BuildContext context){
    Navigator.of(context).pushNamed(CategoryMealsScreen.routeName , arguments: {
      'id' : id,
      'title': title
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => selectCategory(context)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
          colors: [
            color.withOpacity(0.7),
            color
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.circular(10),
          color: color
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
          ),
      ),
    );
  }
}