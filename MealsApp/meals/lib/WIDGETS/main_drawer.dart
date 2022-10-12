import 'package:flutter/material.dart';
import 'package:meals/SCREENS/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(title,
          style: const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 24,
              fontWeight: FontWeight.bold)),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: const Text('cooking up',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.red)),
          ),
          const SizedBox(height: 20),
          buildListTile('Mealz', Icons.restaurant,
              () => Navigator.pushReplacementNamed(context, '/')),
          buildListTile('Filters', Icons.settings, () {
            Navigator.pushReplacementNamed(context, FilterScreen.routeName);
          })
        ],
      ),
    );
  }
}
