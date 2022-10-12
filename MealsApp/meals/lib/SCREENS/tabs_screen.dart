import 'package:flutter/material.dart';
import 'package:meals/SCREENS/categories_screen.dart';
import 'package:meals/SCREENS/favourite_screen.dart';
import 'package:meals/WIDGETS/main_drawer.dart';

import '../MODELS/meals.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favMeal;
  
  TabsScreen(this.favMeal);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late final List<Map<String, Object>> _pages;

  @override
  void initState() {
   _pages = [
    {'page': const CategoryScreen(), 'title': 'Categories'},
    {'page': FavouritesScreen(widget.favMeal), 'title': 'Favourites'}
  ];
    super.initState();
  }

  int _seletedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _seletedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_seletedPageIndex]['title'] as String),
      ),
      drawer: const MainDrawer(),
      body: _pages[_seletedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        currentIndex: _seletedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites')
        ],
      ),
    );
  }
}
