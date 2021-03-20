import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crescendo_hack/essentials/loading.dart';
import 'package:crescendo_hack/pages/dashboard.dart';
import 'package:crescendo_hack/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Register extends StatefulWidget {
  final String uid;
  Register({Key key, this.uid}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  var error = "";

  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
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

  // Future<void> _showDialog(BuildContext context){
  //   return showDialog(context: context, builder: (BuildContext context) {
  //     return AlertDialog(
  //       title: Text("Make a Choice"),
  //       content: SingleChildScrollView(
  //         child: ListBody(
  //           children: <Widget>[
  //             GestureDetector(
  //               child: Text("Gallery"),
  //               onTap: () {
  //                 _openGallery();
  //               },
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(8.0),
  //             ),
  //             GestureDetector(
  //               child: Text("Camera"),
  //               onTap: () {
  //                 _openCamera();
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   });
  // }

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
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("images/reg_back.png"),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 30, right: 20),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 20,
                          left: 10,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login(),
                                      fullscreenDialog: true));
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
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
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Center(
                                              child: Text("Register",
                                                  style: TextStyle(
                                                    // fontSize: ScreenUtil().setSp(45),
                                                      fontSize: 25,
                                                      fontFamily: "Poppins-Bold",
                                                      fontWeight: FontWeight.bold,
                                                      letterSpacing: .6)),
                                            ),
                                            SizedBox(height: 60,),
                                            Text("Name",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Poppins-Medium",
                                                  fontSize: 15,
                                                )),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: "Name",
                                                  hintStyle:
                                                  TextStyle(color: Colors.black,
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
                                                  fontSize: 15,
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
                                                  fontSize: 15,
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
                                            SizedBox(height: 15),
                                            // Text("Mobile No.",
                                            //     style: TextStyle(
                                            //         fontWeight: FontWeight.bold,
                                            //         fontFamily: "Poppins-Medium",
                                            //         // fontSize: ScreenUtil().setSp(30)
                                            //       fontSize: 20,
                                            //     )),
//                 TextFormField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       hintText: "Mobile No.",
//                       hintStyle:
//                       TextStyle(color: Colors.black, fontSize: 15.0)),
// //                  keyboardType: TextInputType.emailAddress,
// //                  validator: (item) {
// //                    return item.contains("@") ? null : "Enter valid Email";
// //                  },
// //                  onChanged: (item) {
// //                    setState(() {
// //                      _email = item;
// //                    });
// //                  },
//                   //controller: _email,
//                   //keyboardType: TextInputType.emailAddress,
//                   //validator: emailValidator,
//
//                 ),
                                            SizedBox(height: 15),
                                            Center(
                                              child: Container(
                                                width: 200,
                                                height: 40,
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => DashboardPage()));
                                                  },
                                                  child: Text(
                                                    'Register',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 19,
                                                    ),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius
                                                        .circular(30.0),
                                                  ),
                                                  color: Colors.white,
                                                  splashColor: Colors.blue,
                                                  textColor: Colors.black,
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
                                              margin: const EdgeInsets.only(
                                                  left: 20.0, right: 10.0),
                                              child: Divider(
                                                color: Colors.black,
                                                thickness: 3.0,
                                              ),
                                            )),
                                      ]),
                                      SizedBox(height: 15),
                                      _signInButton(),
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
                                                color: Colors.white,
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


  Widget _signInButton() {
    return FlatButton(
      color: Colors.white,
      splashColor: Colors.grey,
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
            Image(image: AssetImage("images/google.png"), height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign up with Google',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}