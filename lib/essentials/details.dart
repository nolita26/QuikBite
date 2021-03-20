import 'package:crescendo_hack/essentials/themecolor.dart';
import 'package:flutter/material.dart';
import 'package:crescendo_hack/essentials/recipe.dart';

class Details extends StatelessWidget {
  final Recipe recipe;

  Details(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.asset(
                    '${recipe.image}',
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: '${recipe.recipe} \n',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Everyone loves a taco, or even a small taquito with a cool glass of something. Pile on the tomatillo salsa, curtido and fresh guacamole. With versatile, customisable dishes, Mexican food lends itself to big sharing dinners and casual help-yourself feasts. We could eat Mexican for every meal with huevos rancheros for breakfast and pulled pork tacos for supper.',
                      ),
                    ],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: kThemeColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:10),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Nutritional Track\n',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: 'Best',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Click here for Recipe',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 20,
            left: 10,
            child:  GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}