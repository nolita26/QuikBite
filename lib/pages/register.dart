import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crescendo_hack/essentials/loading.dart';
import 'package:crescendo_hack/pages/dashboard.dart';
import 'package:crescendo_hack/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login.dart';

class Register extends StatefulWidget {
  final String uid;
  Register({Key key, this.uid}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isLoading = false;
  var error = "";

  @override
  void initState() {
    super.initState();
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();
    print("User Sign Out");
  }

  void register() {
    if (_registerFormKey.currentState.validate()) {
      setState(() => isLoading = true);
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text)
          .then((currentUser) =>
          Firestore.instance
              .collection("Users")
              .document(currentUser.user.uid)
              .setData({
            "uid": currentUser.user.uid,
            "name": nameController.text,
            "email": emailController.text,
            "password": passwordController.text
          }).then((result) =>
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardPage(),
                    fullscreenDialog: true)),
            nameController.clear(),
            emailController.clear(),
            passwordController.clear()
          })
              .catchError((e) => print(e)))
          .catchError((e) => print(e));
      print("registered");
    } else {
      setState(() {
        error = 'Please check the details entered';
        isLoading = false;
      });
    }
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 25),)),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 30, right: 20),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Form(
                                key: _registerFormKey,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16.0, right: 16.0, top: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 60,),
                                            Text("Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Poppins-Medium",
                                                  fontSize: 20,
                                                )),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: "Name",
                                                  hintStyle: TextStyle(color: Colors.black,
                                                      fontSize: 15.0)),
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value.length < 3 ||
                                                    value.isEmpty) {
                                                  return 'Enter Full Name';
                                                }
                                                return null;
                                              },
                                              controller: nameController,
                                            ),
                                            SizedBox(height: 10),
                                            Text("E-mail",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Poppins-Medium",
                                                  fontSize: 20,
                                                )),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: "E-mail",
                                                  hintStyle:
                                                  TextStyle(color: Colors.black,
                                                      fontSize: 15.0)),
                                              keyboardType: TextInputType
                                                  .emailAddress,
                                              validator: emailValidator,
                                              controller: emailController,
                                            ),
                                            SizedBox(height: 10),
                                            Text("Password",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Poppins-Medium",
                                                  // fontSize: ScreenUtil().setSp(30)
                                                  fontSize: 20,
                                                )),
                                            TextFormField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  hintText: "Password",
                                                  hintStyle:
                                                  TextStyle(color: Colors.black,
                                                      fontSize: 15.0)),
                                              keyboardType: TextInputType.text,
                                              controller: passwordController,
                                              validator: pwdValidator,
                                            ),
                                            SizedBox(height: 25),
                                            Center(
                                              child: Container(
                                                width: 200,
                                                height: 50,
                                                child: RaisedButton(
                                                  onPressed: register,
                                                  child: Text(
                                                    'Register',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius
                                                        .circular(30.0),
                                                  ),
                                                  color: Colors.black,
                                                  splashColor: Colors.blue,
                                                  textColor: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Row(children: <Widget>[
                                        Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10.0, right: 20.0),
                                              child: Divider(
                                                color: Colors.white,
                                                thickness: 3.0,
                                              ),
                                            )),
                                        Text(
                                          "OR",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20.0, right: 10.0),
                                              child: Divider(
                                                color: Colors.black,
                                                thickness: 3.0,
                                              ),
                                            )),
                                      ]),
                                      SizedBox(height: 15),
                                      FlatButton(
                                        color: Colors.black,
                                        splashColor: Colors.white,
                                        onPressed: () {
                                          signInWithGoogle().whenComplete(() {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return DashboardPage(uid: widget.uid,);
                                                },
                                              ),
                                            );
                                          });
                                        },
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image(image: AssetImage("images/googlee.png"), height: 30.0),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text(
                                                  'Sign up with Google',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Text(
                                            'Have an account?',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          InkWell(
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration
                                                    .underline,
                                                fontSize: 17,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login(),
                                                      fullscreenDialog: true));
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}