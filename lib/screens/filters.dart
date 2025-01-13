import 'package:flutter/material.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/new_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  nonVegetarian,
}
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _nonVegetarianFilterSet = false;
  var _vegetarianFilterSet = false;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _nonVegetarianFilterSet = widget.currentFilters[Filter.nonVegetarian]!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.push(context, MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      // }),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result){
          if(didPop) {
            return;
          }
          Navigator.of(context).pop(
            {
              Filter.glutenFree: _glutenFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
              Filter.nonVegetarian: _nonVegetarianFilterSet,
            }
          );
        },
        child: Column(
          children: [
            SwitchListTile(
              title: Text('Gluten-free', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),),
              subtitle: Text('Only include gluten-free meals.', style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              )),
              value: _glutenFreeFilterSet,
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 30),
              onChanged: (newValue) {
                setState(() {
                  _glutenFreeFilterSet = newValue;
                });
              },
            ),
            SwitchListTile(
              title: Text('Lactose-free', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),),
              subtitle: Text('Only include Lactose-free meals.', style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              )),
              value: _lactoseFreeFilterSet,
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 30),
              onChanged: (newValue) {
                setState(() {
                  _lactoseFreeFilterSet = newValue;
                });
              },
            ),
            SwitchListTile(
              title: Text('Vegetarian', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),),
              subtitle: Text('Only include vegetarian meals.', style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              )),
              value: _vegetarianFilterSet,
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 30),
              onChanged: (newValue) {
                setState(() {
                  _vegetarianFilterSet = newValue;
                });
              },
            ),
            SwitchListTile(
              title: Text('Non-Vegetarian', style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),),
              subtitle: Text('Only include non-vegetarian meals.', style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              )),
              value: _nonVegetarianFilterSet,
              activeColor: Theme.of(context).colorScheme.primary,
              contentPadding: EdgeInsets.only(left: 34, right: 30),
              onChanged: (newValue) {
                setState(() {
                  _nonVegetarianFilterSet = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
