import 'package:crescendo_hack/essentials/getstarted.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Splash(),
));

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.white,
      image: Image.asset('images/logo.png', height: 150, width: 150,),
      loaderColor: Colors.black,
      photoSize: 180.0,
      navigateAfterSeconds: GetStarted(),
//      TODO: Add Wrapper , Once Firebase Authentication is sorted
    );
  }
}