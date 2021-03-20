import 'package:crescendo_hack/essentials/themecolor.dart';
import 'package:crescendo_hack/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      body: Center(
          child: Text('Get Started', style: TextStyle(color: kThemeColor, fontSize: 25),)
      ),
    );
  }
}