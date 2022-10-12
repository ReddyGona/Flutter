import 'package:flutter/material.dart';
import 'package:meals/DATA/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/mealDetail';

  final Function toggleFav;
  final Function isFavourite;

  const MealDetailScreen(this.toggleFav, this.isFavourite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.titleSmall),
    );
  }

  Widget buildContainer(BuildContext context, Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: child);
  }


  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
        appBar: AppBar(title: Text(selectedMeal.title)),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=> toggleFav(mealId),
          child: Icon(isFavourite(mealId) ? Icons.star : Icons.star_border),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    selectedMeal.imageUrl,
                    fit: BoxFit.cover,
                  )),
              buildSectionTitle(context, 'Ingredients'),
              buildContainer(
                context,
                ListView.builder(
                    itemBuilder: (ctx, index) => Card(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(selectedMeal.ingredients[index]),
                          ),
                        ),
                    itemCount: selectedMeal.ingredients.length),
              ),
              buildSectionTitle(context, 'Steps'),
              buildContainer(
                  context,
                  ListView.builder(
                    itemBuilder: (ctx, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(child: Text('# ${index + 1}')),
                          title: Text(selectedMeal.steps[index],
                              style: const TextStyle(fontSize: 16)),
                        ),
                        const Divider(thickness: 1)
                      ],
                    ),
                    itemCount: selectedMeal.steps.length,
                  ))
            ],
          ),
        ));
  }
}
