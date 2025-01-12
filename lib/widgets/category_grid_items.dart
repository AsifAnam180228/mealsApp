import 'package:meals_app/models/category.dart';
import 'package:flutter/material.dart';

class CategoryGridItems extends StatelessWidget {
  const CategoryGridItems({super.key, required this.category, required this.onSelectCategory});

  final Category category;
  final Function() onSelectCategory;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>{
        onSelectCategory(),
      },
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
          colors: [
            Color.alphaBlend(category.color.withAlpha(128), Colors.transparent),
            Color.alphaBlend(category.color.withAlpha(64), Colors.transparent),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }
}
