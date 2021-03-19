import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:crescendo_hack/intropages/intro_layout.dart';

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
      image: Image.asset(''),
      loaderColor: Colors.black,
      photoSize: 180.0,
      navigateAfterSeconds: IntroLayout(),
//      TODO: Add Wrapper , Once Firebase Authentication is sorted
    );
  }
}