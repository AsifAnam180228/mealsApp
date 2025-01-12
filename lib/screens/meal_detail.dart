import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key, required this.meal, required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              icon: Icon(Icons.star_border),
              onPressed: () {
                onToggleFavorite(meal);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(

          child: Column(
            children: [
              FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
              SizedBox(
                height: 14,
              ),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.brown[900],
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          "Ingredients",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
              SizedBox(
                height: 14,
              ),
              for (final ingredient in meal.ingredients)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      ingredient,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
                ),
          
              SizedBox(
                height: 24,
              ),
              Container(
  width: double.infinity,
  decoration: BoxDecoration(
    color: Colors.brown[900],
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(0, 2),
        blurRadius: 6,
      ),
    ],
  ),
  padding: const EdgeInsets.symmetric(vertical: 8),
  child: Text(
    "Steps",
    style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
    textAlign: TextAlign.center,
  ),
),
              SizedBox(
                height: 14,
              ),
              for (final steps in meal.steps)
                SafeArea(
                  maintainBottomViewPadding: true,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text(
                        steps,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }
}
