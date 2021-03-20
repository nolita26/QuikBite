import 'package:crescendo_hack/essentials/themecolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  categoryButton({image, title}) {
    return FlatButton(
      onPressed: () {},
      padding: EdgeInsets.only(top: 20),
      child: Container(
        height: 120,
        width: 120,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.0),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
      //onPressed: ()=> _loadCategoryScreen(context, "$category"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Search", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
          elevation: 0,
          leading: GestureDetector(
            onTap: (){
            Navigator.pop(context);
          },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.only(top: 20),
              //   child: Center(
              //     child: Text(
              //       'Search',
              //       style: TextStyle(
              //         fontWeight: FontWeight.w900,
              //         fontSize: 32,
              //         color: kThemeColor,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 2, 20, 4),
                  decoration: BoxDecoration(),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                      hintText: "Example Continental Food etc",
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 5),
                child: Center(
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10),
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        categoryButton(
                          image: 'images/f1.jpg',
                          title: 'Italian',
                        ), //Makeup
                        categoryButton(
                          image: 'images/f3.jpg',
                          title: 'South Indian',
                        ), //Skin care
                      ],
                    ), //Makeup, Skin Care
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        categoryButton(
                          image: 'images/f2.jpg',
                          title: 'Britian',
                        ), //Nutrition/ Dietitian
                        categoryButton(
                          image: 'images/f1.jpg',
                          title: 'German',
                        ), //Nail art
                      ],
                    ), //Nutrition/ Dietitian,Nail art
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        categoryButton(
                          image: 'images/f4.jpg',
                          title: 'Russian',
                        ), // Hair
                        categoryButton(
                            image: 'images/f3.jpg',
                            title: 'Italian'
                        ), // Spa
                      ],
                    ), //Hair courses,Spa therapist
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}