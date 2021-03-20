import 'package:crescendo_hack/essentials/themecolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecommendationsPage extends StatefulWidget {
  @override
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommendations", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          RaisedButton(
            onPressed: () {
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
      body: Center(child: Text('Recommendations', style: TextStyle(color: kThemeColor, fontSize: 25),)),
    );
  }
}