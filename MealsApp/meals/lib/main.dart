import 'package:flutter/material.dart';
import 'package:meals/DATA/dummy_data.dart';
import 'package:meals/SCREENS/category_meals_screen.dart';
import 'package:meals/SCREENS/filters_screen.dart';
import 'package:meals/SCREENS/meal_detail_screen.dart';
import 'package:meals/SCREENS/tabs_screen.dart';

import 'MODELS/meals.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
   List<Meal> _favMeals = [];

  void _setFilters(Map<String, bool> filterdata){
    setState(() {
      _filters = filterdata;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten']! && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose']! && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan']! && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian']! && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFav(String mealId){
    final existingIndex = _favMeals.indexWhere((meal)=> meal.id == mealId);
    if(existingIndex >=0){
     setState(() {
        _favMeals.removeAt(existingIndex);
     });
    }else{
     setState(() {
        _favMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
     });
    }
  }

  bool _isMealFavourited(String id){
    return _favMeals.any((meal) => meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desi Meals',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: Colors.amber,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodySmall: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyMedium:  const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          titleMedium: const TextStyle(fontSize: 24, fontFamily: 'RobotoCondensed'),
          titleSmall: const TextStyle(fontSize: 18, fontFamily: 'RobotoCondensed', fontWeight: FontWeight.bold),
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) =>  TabsScreen(_favMeals),
        CategoryMealsScreen.routeName: (ctx) =>   CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx)=>  MealDetailScreen(_toggleFav, _isMealFavourited),
        FilterScreen.routeName: (ctx)=>  FilterScreen(_setFilters, _filters)
      },
      onUnknownRoute: ((settings) {
        return MaterialPageRoute(builder: (ctx)=>  CategoryMealsScreen(_availableMeals));
      }),
    );
  }
}
