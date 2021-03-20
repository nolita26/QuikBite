import 'package:flutter/material.dart';
import 'package:crescendo_hack/essentials/recipe.dart';
import 'package:crescendo_hack/essentials/imagecard.dart';

class ImageCards extends StatefulWidget {
  @override
  _ImageCardsState createState() => _ImageCardsState();
}

class _ImageCardsState extends State<ImageCards> {
  List<Recipe> recipes = [
    Recipe(recipe: 'Huevos Rancheros', image: 'images/f1.jpg'),
    Recipe(recipe: 'Chinese Oriental Plate', image: 'images/f2.jpg'),
    Recipe(recipe: 'German Apfelschorle', image: 'images/f3.jpg'),
    Recipe(recipe: 'Thai Guay Teow', image: 'images/f4.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (_, index) {
              return ImageCard(
                recipe: recipes[index],
                name: recipes[index].recipe,
                picture: recipes[index].image,
              );
            }
        )
    );
  }
}