import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';

import 'categories.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  String activePageTitle = 'Categories';
  final List<Meal> _favoriteMeals = [];
  void _toggleFavoriteMeal(Meal meal){
    final _isExisting = _favoriteMeals.contains(meal);

    if(_isExisting){
      setState(() {
        _favoriteMeals.remove(meal);
      });
    }
    else{
      setState(() {
        _favoriteMeals.add(meal);
      });
    }

  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
        print('------------------------------------------------------');
        print(_selectedPageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(onToggleFavorite: _toggleFavoriteMeal,);
    if(_selectedPageIndex == 1){
      activePage = MealsScreen(meals: _favoriteMeals, onToggleFavorite: _toggleFavoriteMeal,);
      activePageTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
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

