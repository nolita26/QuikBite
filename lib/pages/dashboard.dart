import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crescendo_hack/essentials/themecolor.dart';
import 'package:crescendo_hack/pages/homepage.dart';
import 'package:crescendo_hack/pages/Ingredients.dart';
import 'package:crescendo_hack/pages/profilepage.dart';
import 'package:crescendo_hack/pages/recommendationpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  String uid;
  DashboardPage({Key key, this.uid}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  final GlobalKey<ScaffoldState>_scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  Widget _showPage = new HomePage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return HomePage();
        break;
      case 1:
        return Ingredients();
        break;
      case 2:
        return RecommendationsPage();
        break;
      case 3:
        return MainCard();
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text('No page found', style: TextStyle(fontSize: 30),),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        color: Colors.black,
        backgroundColor: Colors.white,
        buttonBackgroundColor: kThemeColor,
        items: <Widget>[
          IconButton(icon: Icon(Icons.home, color: Colors.white,),),
          IconButton(icon: Icon(Icons.local_bar, color: Colors.white,),),
          IconButton(icon: Icon(Icons.star, color: Colors.white,),),
          IconButton(icon: Icon(Icons.person, color: Colors.white,),),
        ],
        animationDuration: Duration(milliseconds: 400),
        onTap: (int tappedIndex) {
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
        },
      ),
    );
  }
}