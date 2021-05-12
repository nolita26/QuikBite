import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crescendo_hack/pages/dashboard.dart';
import 'package:crescendo_hack/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../essentials/loading.dart';
import 'dashboard.dart';
import 'dashboard.dart';
import 'register.dart';

class Login extends StatefulWidget {
  final String uid;
  Login({Key key, this.uid}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();
  bool rememberMe = false;
  var error = "";
  bool isLoading = false;

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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;
    if (rememberMe) {} else {
      // TODO: Forget the user
    }
  });

  void login() {
    if (_loginFormKey.currentState.validate()) {
      setState(() => isLoading = true);
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text)
          .then((currentUser) => Firestore.instance
          .collection("Users")
          .document(currentUser.user.uid)
          .get()
          .then((DocumentSnapshot result) =>
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(
              builder: (context) => DashboardPage(uid: currentUser.user.uid)), (_) => false),)
          .catchError((e) => print(e)))
          .catchError((e) {
        print(e);
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          // child: AlertDialog(
          //   title: Text('Error'),
          //   content: Text('Check your details'),
          // )
        );
      });
      print("logged in");
    } else {
      setState(() {
        error = 'Please check your email and password';
      });
      showDialog(
        context: context,
        // child: AlertDialog(
        //   title: Text('Error'),
        //   content: Text('Please check email and password'),
        //   actions: [
        //     FlatButton(
        //       child: Text('OK'),
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //     )
        //   ],
        // )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 25),)),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: Colors.white,
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
                                  key: _loginFormKey,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              // Text("Login",
                                              //     style: TextStyle(
                                              //       // fontSize: ScreenUtil().setSp(45),
                                              //         fontSize: 30,
                                              //         fontFamily: "Poppins-Bold",
                                              //         fontWeight: FontWeight.bold,
                                              //         letterSpacing: .6)),

                                              SizedBox(
                                                // height: ScreenUtil().setHeight(75),
                                                height: 40,
                                              ),
                                              Text("E-Mail",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Poppins-Medium",
                                                    fontSize: 20,
                                                    // fontSize: ScreenUtil().setSp(30)
                                                  )),
                                              TextFormField(
                                                keyboardType: TextInputType.emailAddress,
                                                validator: emailValidator,
                                                controller: emailController,
                                                decoration: InputDecoration(
                                                    hintText: "E-Mail",
                                                    hintStyle: TextStyle(color: Colors.black, fontSize: 15)),
                                              ),
                                              SizedBox(height: 20,),
                                              Text("Password",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Poppins-Medium",
                                                    fontSize: 20,
                                                  )),
                                              TextFormField(
                                                obscureText: true,
                                                controller: passwordController,
                                                validator: (item) {
                                                  return item.length > 7 ? null : "Password must be at least 8 characters";
                                                },
                                                decoration: InputDecoration(
                                                    hintText: "Password",
                                                    hintStyle: TextStyle(color: Colors.black, fontSize: 15.0)),
                                              ),
                                              SizedBox(height: 20),
                                              GestureDetector(
                                                onTap: () {
                                                  // Navigator.push(context, MaterialPageRoute(builder: (_) => ForgetPass()));
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text(
                                                      "Forgot Password?",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: "Poppins-Medium",
                                                        fontSize: 15,
                                                        // fontSize: ScreenUtil().setSp(30),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              Center(
                                                child: Container(
                                                  width: 200,
                                                  height: 50,
                                                  child: RaisedButton(
                                                    onPressed: login,
                                                    child: Text(
                                                      'Sign In',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: new BorderRadius.circular(30.0),
                                                    ),
                                                    color: Colors.black,
                                                    splashColor: Colors.blue,
                                                    textColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        Row(children: <Widget>[
                                          Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                                                child: Divider(
                                                  color: Colors.black,
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
                                                margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                                                child: Divider(
                                                  color: Colors.black,
                                                  thickness: 3.0,
                                                ),
                                              )),
                                        ]),
                                        SizedBox(height: 25),
                                        FlatButton(
                                          color: Colors.black,
                                          splashColor: Colors.white,
                                          onPressed: () {
                                            signInWithGoogle().whenComplete(() {
                                              Navigator.pushAndRemoveUntil(
                                                  context, MaterialPageRoute(
                                                  builder: (context) => DashboardPage(uid: widget.uid,)),
                                                      (_) => false);
                                            });
                                          },
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image(image: AssetImage("images/googlee.png"), height: 35.0),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Text(
                                                    'Sign in with Google',
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
                                        SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'New here?',
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
                                                'Register',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                  decoration: TextDecoration.underline,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Register(),
                                                        fullscreenDialog: true));
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
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
        )
    );
  }
}