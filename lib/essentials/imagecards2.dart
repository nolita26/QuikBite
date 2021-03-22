import 'package:flutter/material.dart';
import 'package:crescendo_hack/essentials/recipe.dart';
import 'package:crescendo_hack/essentials/imagecard.dart';

class ImageCards2 extends StatefulWidget {
  @override
  _ImageCards2State createState() => _ImageCards2State();
}

class _ImageCards2State extends State<ImageCards2> {
  List<Recipe> recipes2 = [
    Recipe(recipe: 'Masala Dosa', image: 'images/f9.jpg'),
    Recipe(recipe: 'Aloo Paratha', image: 'images/f10.jpg'),
    Recipe(recipe: 'Samosa', image: 'images/f11.jpg'),
    Recipe(recipe: 'Fluffed Dhokla', image: 'images/f12.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipes2.length,
            itemBuilder: (_, index) {
              return ImageCard(
                recipe: recipes2[index],
                name: recipes2[index].recipe,
                picture: recipes2[index].image,
              );
            }
        )
    );
  }
}