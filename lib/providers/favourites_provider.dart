import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavouritesMealNotifier extends StateNotifier<List<Meal>>{
  FavouritesMealNotifier() : super([]);

}

final favouriteMealsProvider = StateNotifierProvider<FavouritesMealNotifier, List<Meal>>((ref){
  return FavouritesMealNotifier();
});