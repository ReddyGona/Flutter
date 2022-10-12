import 'package:flutter/material.dart';

import '../MODELS/meals.dart';
import '../WIDGETS/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favMeals;

  const FavouritesScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {

    if(favMeals.isEmpty){
      return const Center(
              child: Text("You have no favourites yet - start adding some"),
    );
    }else{
      return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: favMeals[index].id,
              title: favMeals[index].title,
              imageUrl: favMeals[index].imageUrl,
              duration: favMeals[index].duration,
              complexity: favMeals[index].complexity,
              affordability: favMeals[index].affordability,
            );
          },
          itemCount: favMeals.length,
        );
    }
   
  }
}