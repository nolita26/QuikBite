import 'package:flutter/material.dart';
import 'package:crescendo_hack/essentials/recipe.dart';
import 'package:crescendo_hack/essentials/imagecard.dart';

class ImageCards1 extends StatefulWidget {
  @override
  _ImageCards1State createState() => _ImageCards1State();
}

class _ImageCards1State extends State<ImageCards1> {
  List<Recipe> recipes1 = [
    Recipe(recipe: 'Pepperoni Pizza', image: 'images/f5.jpg'),
    Recipe(recipe: 'Pancakes', image: 'images/f6.jpg'),
    Recipe(recipe: 'French Toasts', image: 'images/f7.jpg'),
    Recipe(recipe: 'Scambled eggs with Bacon', image: 'images/f8.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipes1.length,
            itemBuilder: (_, index) {
              return ImageCard(
                recipe: recipes1[index],
                name: recipes1[index].recipe,
                picture: recipes1[index].image,
              );
            }
        )
    );
  }
}