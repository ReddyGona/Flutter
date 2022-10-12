import 'package:flutter/material.dart';
import 'package:meals/WIDGETS/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filterScreen';
  final Function saveFilters;
  final Map<String, bool> currentFilter;
  const FilterScreen(this.saveFilters, this.currentFilter);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarianFree = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilter['gluten']!;
    _lactoseFree = widget.currentFilter['lactose']!;
    _vegan = widget.currentFilter['vegan']!;
    _vegetarianFree = widget.currentFilter['vegetarian']!;
    super.initState();
  }

  Widget _buildSwitchTile(String title, String description, bool currentValue,
      Function(bool) updateValue) {
    return SwitchListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        value: currentValue,
        subtitle: Text(description, style: const TextStyle(color: Colors.grey)),
        onChanged:   updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Filters",),
          actions: [
            IconButton(
              onPressed: () { 
                final selectedFilters =  {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarianFree
                };
                widget.saveFilters(selectedFilters);
                }, 
              icon: const Icon(Icons.save))
          ],),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchTile(
                      'Gluten-free',
                      'Only include gluten-free meals',
                      _glutenFree, (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }),
                  _buildSwitchTile(
                      'Lactose-free',
                      'Only include lactose-free meals',
                      _lactoseFree, (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }),
                  _buildSwitchTile(
                      'Vegetarian-free',
                      'Only include vegetarian-free meals', 
                       _vegetarianFree, 
                       (newValue) {
                         setState(() {
                           _vegetarianFree = newValue;
                         });
                    }),
                  _buildSwitchTile(
                    'Vegan-free',
                    'Only include vegan-free meals', 
                    _vegan, 
                    (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                  })
                ],
              ),
            )
          ],
        ));
  }
}
