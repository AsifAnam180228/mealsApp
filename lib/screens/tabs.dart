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

