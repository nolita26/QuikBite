import 'package:crescendo_hack/intropages/intro_layout.dart';
import 'package:crescendo_hack/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crescendo_hack/services/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    //return either home or authenticate widget
    if (user == null) {
      return IntroLayout();
    } else {
      return Login();
    }
  }
}
