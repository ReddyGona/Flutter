import 'package:flutter/material.dart';
import 'package:meals/MODELS/meals.dart';
import 'package:meals/WIDGETS/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/categoryMeals';
  final List<Meal> availableMeals;

  const CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  String? catId;
  List<Meal>? displayedMeals;
  Map? routeArgs;

  bool _loadedinitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadedinitData){
       routeArgs =  ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs!['title'];
      catId = routeArgs!['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(catId);
      }).toList();
      _loadedinitData = true;
    }
    super.didChangeDependencies();
  }

  // void _removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeals!.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(categoryTitle!)),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals![index].id,
              title: displayedMeals![index].title,
              imageUrl: displayedMeals![index].imageUrl,
              duration: displayedMeals![index].duration,
              complexity: displayedMeals![index].complexity,
              affordability: displayedMeals![index].affordability,
            );
          },
          itemCount: displayedMeals?.length,
        ));
  }
}
