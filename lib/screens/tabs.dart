import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/new_drawer.dart';

import 'categories.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.nonVegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  Map<Filter, bool> _selectedFilter = kInitialFilter;

  int _selectedPageIndex = 0;
  String activePageTitle = 'Categories';
  final List<Meal> _favoriteMeals = [];
  void _toggleFavoriteMeal(Meal meal){
    final isExisting = _favoriteMeals.contains(meal);

    if(isExisting){
      setState(() {
        _favoriteMeals.remove(meal);

      });
      _showInfoMessage('Removed from favorites');
    }
    else{
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Added to favorites');
    }

  }
  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        animation: AnimationController(vsync: ScaffoldMessenger.of(context), animationBehavior:  AnimationBehavior.normal),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        content: Text(message),
        duration: const Duration(seconds: 4),
        showCloseIcon: true,
        closeIconColor: Colors.red[800],
        elevation: 10,
      ),
    );
  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
        print('------------------------------------------------------');
        print(_selectedPageIndex);
    });
  }

  void _selectScreen(String identifier) async {
    Navigator.of(context).pop();
    if(identifier == 'filters'){
      final result = await Navigator.push<Map<Filter, bool>>(context, MaterialPageRoute(builder: (ctx) => FiltersScreen(currentFilters: _selectedFilter,)));
      if(result != null){
        if (kDebugMode) {
          print('------------------------------------------------------');
          print(result);
        }
      }
      setState(() {
        _selectedFilter = result?? kInitialFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final _availableMeals = meals.where((meal) {
      if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilter[Filter.nonVegetarian]! && meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(onToggleFavorite: _toggleFavoriteMeal, availableMeals: _availableMeals,);
    if(_selectedPageIndex == 1){
      activePage = MealsScreen(meals: _favoriteMeals, onToggleFavorite: _toggleFavoriteMeal,);
      activePageTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _selectScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

