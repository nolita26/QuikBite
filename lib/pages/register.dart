// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:crescendo_hack/pages/login.dart';
// import 'package:crescendo_hack/services/auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:crescendo_hack/services/sign_in.dart';
// import 'package:crescendo_hack/services/user.dart';
//
// class Register extends StatefulWidget {
//   @override
//   _RegisterState createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   var _formkey = GlobalKey<FormState>();
//   String _email, _password;
//   bool isLoading = false;
//
//   // AuthService _authService = AuthService();
//   TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
//
// //  File image;
//
//   _openCamera() async{
// //    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
// //    this.setState(() {
// //      image = picture as File;
// //    });
//   }
//
//   _openGallery() async{
// //    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
// //    this.setState(() {
// //      image = picture as File;
// //    });
//   }
//
//   Future<void> _showDialog(BuildContext context){
//     return showDialog(context: context, builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Make a Choice"),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               GestureDetector(
//                 child: Text("Gallery"),
//                 onTap: () {
//                   _openGallery();
//                 },
//               ),
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//               ),
//               GestureDetector(
//                 child: Text("Camera"),
//                 onTap: () {
//                   _openCamera();
//                 },
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   /*void initState() {
//     // TODO: implement initState
//     _email=new TextEditingController();
//     _password=new TextEditingController();
//     super.initState();
//   }*/
//   String emailValidator(String value) {
//     Pattern pattern =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regex = new RegExp(pattern);
//     if (!regex.hasMatch(value)) {
//       return 'Email format is invalid';
//     } else {
//       return null;
//     }
//   }
//
//   String pwdValidator(String value) {
//     if (value.length < 8) {
//       return 'Password must be longer than 8 characters';
//     } else {
//       return null;
//     }
//   }
//   @override
//   @override
//   Widget build(BuildContext context) {
//     // ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true);
//     return Scaffold(
//       resizeToAvoidBottomPadding: true,
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             fit: BoxFit.cover,
//             image: AssetImage("images/reg_back.png"),
//           ),
//         ),
//         child: Stack(
//           children: <Widget>[
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: double.infinity,
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 20, top: 30, right: 20),
//                   child: Stack(
//                     children: <Widget>[
//                       Positioned(
//                         top: 20,
//                         left: 10,
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => Login(),
//                                     fullscreenDialog: true));
//                           },
//                           child: Align(
//                             alignment: Alignment.topLeft,
//                             child: Icon(
//                               Icons.arrow_back_ios,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             RegisterForm(),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ignore: non_constant_identifier_names
//   Center RegisterForm() {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Center(
//                   child: Text("Register",
//                       style: TextStyle(
//                           // fontSize: ScreenUtil().setSp(45),
//                         fontSize: 25,
//                           fontFamily: "Poppins-Bold",
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: .6)),
//                 ),
//                 SizedBox(
//                   // height: ScreenUtil().setHeight(75),
//                   height: 60,
//                 ),
//                 Text("E-mail",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontFamily: "Poppins-Medium",
//                         // fontSize: ScreenUtil().setSp(30)
//                       fontSize: 15,
//                     )),
//                 TextFormField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       hintText: "E-mail",
//                       hintStyle:
//                       TextStyle(color: Colors.black, fontSize: 15.0)),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (item) {
//                     return item.contains("@") ? null : "Enter valid Email";
//                   },
//                   onChanged: (item) {
//                     setState(() {
//                       _email = item;
//                     });
//                   },
//                   //controller: _email,
//                   //keyboardType: TextInputType.emailAddress,
//                   //validator: emailValidator,
//                 ),
//                 SizedBox(
//                   // height: ScreenUtil().setHeight(20),
//                   height: 10,
//                 ),
//                 Text("Password",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontFamily: "Poppins-Medium",
//                         // fontSize: ScreenUtil().setSp(30)
//                       fontSize: 15,
//                     )),
//                 TextFormField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                       hintText: "Password",
//                       hintStyle:
//                       TextStyle(color: Colors.black, fontSize: 15.0)),
//                   keyboardType: TextInputType.text,
//                   validator: (item) {
//                     return item.length > 7 ? null : "Password must be at least 8 characters";
//                   },
//                   onChanged: (item) {
//                     setState(() {
//                       _password = item;
//                     });
//                   },
//                   //controller: _password,
//                   //validator: pwdValidator,
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Text("Mobile No.",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontFamily: "Poppins-Medium",
//                         // fontSize: ScreenUtil().setSp(30)
//                       fontSize: 20,
//                     )),
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
//                 SizedBox(height: 15),
//                 Text("Upload an image",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontFamily: "Poppins-Medium",
//                         // fontSize: ScreenUtil().setSp(30)
//                       fontSize: 15,
//                     )),
//                 RaisedButton(
//                   color: Colors.white,
//                   onPressed: () {
//                     _showDialog(context);
//                   },
//                   child: Text("Select Image", style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w600,
//                   )),
//                 ),
// //                TextFormField(
// //                  obscureText: true,
// //                  decoration: InputDecoration(
// //                      hintText: "",
// //                      hintStyle:
// //                      TextStyle(color: Colors.black, fontSize: 15.0)),
// //                  keyboardType: TextInputType.emailAddress,
// //                  validator: (item) {
// //                    return item.contains("@") ? null : "Enter valid Email";
// //                  },
// //                  onChanged: (item) {
// //                    setState(() {
// //                      _email = item;
// //                    });
// //                  },
// //                  //controller: _email,
// //                  //keyboardType: TextInputType.emailAddress,
// //                  //validator: emailValidator,
// //                ),
//                 SizedBox(height: 15),
//                 Center(
//                   child: Container(
//                     width: 200,
//                     height: 40,
//                     child: RaisedButton(
//                       onPressed: () {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password).then((user) {
//                           // sign up
//                           setState(() {
//                             isLoading = false;
//                           });
//                           Fluttertoast.showToast(msg: "Register Success");
//                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Login()), (Route<dynamic> route) => false);
//                         }).catchError((onError) {
//                           setState(() {
//                             isLoading = false;
//                           });
//                           Fluttertoast.showToast(msg: "error " + onError.toString());
//                         });
//                         //Navigator.pop(context);
//                       },
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 19,
//                         ),
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: new BorderRadius.circular(30.0),
//                       ),
//                       color: Colors.white,
//                       splashColor: Colors.blue,
//                       textColor: Colors.black,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   // height: ScreenUtil().setHeight(10),
//                   height: 5,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 15),
//           Row(children: <Widget>[
//             Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.only(left: 10.0, right: 20.0),
//                   child: Divider(
//                     color: Colors.black,
//                     thickness: 3.0,
//                   ),
//                 )),
//             Text(
//               "OR",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20),
//             ),
//             Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.only(left: 20.0, right: 10.0),
//                   child: Divider(
//                     color: Colors.black,
//                     thickness: 3.0,
//                   ),
//                 )),
//           ]),
//           SizedBox(height: 15),
//           _signInButton(),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Have an account?',
//                 style: TextStyle(
//                   fontFamily: 'Montserrat',
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 17,
//                 ),
//               ),
//               SizedBox(
//                 width: 5.0,
//               ),
//               InkWell(
//                 child: Text(
//                   'Login',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: 'Montserrat',
//                     fontWeight: FontWeight.bold,
//                     decoration: TextDecoration.underline,
//                     fontSize: 17,
//                   ),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => Login(),
//                           fullscreenDialog: true));
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _signInButton() {
//     return FlatButton(
//       color: Colors.white,
//       splashColor: Colors.grey,
//       onPressed: () {
//         // signInWithGoogle().whenComplete(() {
//         //   Navigator.of(context).push(
//         //     MaterialPageRoute(
//         //       builder: (context){
//         //         return Login();
//         //       },
//         //     ),
//         //   );
//         // });
//       },
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image(image: AssetImage("images/google.png"), height: 30.0),
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 'Sign up with Google',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.black,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   // void login() {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   _authService.signInWithEmailAndPassword(_email, _password).then((user) {
//   //     // sign up
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //     Fluttertoast.showToast(msg: "Login Success");
//   //     Navigator.pushAndRemoveUntil(
//   //         context,
//   //         MaterialPageRoute(builder: (_) => Login()),
//   //             (Route<dynamic> route) => false);
//   //   }).catchError((onError) {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //     Fluttertoast.showToast(msg: "error " + onError.toString());
//   //   });
//   // }
// }
//
