import 'package:crescendo_hack/essentials/icon.dart';
import 'package:crescendo_hack/essentials/imagecards.dart';
import 'package:crescendo_hack/essentials/themecolor.dart';
import 'package:crescendo_hack/pages/login.dart';
import 'package:crescendo_hack/pages/search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
              // FirebaseAuth auth = FirebaseAuth.instance;
              // twitterLogin.logOut().then((res) {
              //   print('Signed Out');
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(builder: (context) => LoginPage()),
              //   );
              // }).catchError((e) {
              //   print(e);
              // });
              // _auth.signOut();
            },
            child: Text(
              "Logout",
              style: TextStyle(color: kThemeColor),
            ),
            color: Colors.black,
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: '\t\t\t\t\t\t\t\tQuikBite\n',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: kThemeColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Time to explore more!',
                      ),
                    ],
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchPage()),
                      );
                    },
                    child: IconCard(
                      iconData: Icons.search,
                      text: 'Search',
                    ),
                  ),
                  IconCard(
                      iconData: Icons.track_changes,
                      text: 'Track',
                    ),

                  IconCard(
                    iconData: Icons.explore,
                    text: 'Explore',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text(
                      'Recipes for You',
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
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                    child: ImageCards()
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
          )
      ),
    );
  }
}