import 'package:crescendo_hack/essentials/imagecards.dart';
import 'package:crescendo_hack/essentials/imagecards1.dart';
import 'package:crescendo_hack/essentials/imagecards2.dart';
import 'package:crescendo_hack/essentials/themecolor.dart';
import 'package:crescendo_hack/pages/Ingredients.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Recipies extends StatefulWidget {
  @override
  _RecipiesState createState() => _RecipiesState();
}

class _RecipiesState extends State<Recipies> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Ingredients()));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container (
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text(
                      'Mixed Meals',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                    ),
                    onPressed: (){},
                  ),
                ],
              ),
              Expanded(
                child: Container(
                    child: ImageCards2()
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text(
                      'Breakfast Meals',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                    ),
                    onPressed: (){},
                  ),
                ],
              ),

              Expanded(
                child: Container(
                    child: ImageCards1()
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}