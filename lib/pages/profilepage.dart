import 'package:crescendo_hack/essentials/fadeanim.dart';
import 'package:crescendo_hack/essentials/themecolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white),),
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
              //     MaterialPageRoute(builder: (context) => Login()),
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
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              ProfileCard(),
              Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(0.5, GestureDetector(
                        onTap: () {
                          showBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 500,
                                  padding: EdgeInsets.only(top: 10, bottom: 30),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          leading: IconButton(
                                              icon: Icon(Icons.clear, color: Colors.black,),
                                              iconSize: 25,
                                              onPressed: () {
                                                Navigator.pop(context);
                                                // _ufullnameController.clear(); _udescController.clear(); _umobilenumberController.clear();
                                                // _ulocationController.clear(); _uemailController.clear(); _uwebsiteController.clear();
                                                // _ufacebookController.clear(); _ugithubController.clear(); _ulinkedinController.clear();
                                                // _uinstagramController.clear(); _utwitterController.clear();
                                              }
                                          ),
                                          title: Text('Edit Profile', style: TextStyle(color: kThemeColor, fontSize: 20),),
                                          trailing: IconButton(
                                              icon: Icon(Icons.check, color: Colors.black,),
                                              iconSize: 25,
                                              onPressed: () {
                                                // if (_ufullnameController.text.isNotEmpty || _udescController.text.isNotEmpty || _umobilenumberController.text.isNotEmpty ||
                                                //     _ulocationController.text.isNotEmpty || _uemailController.text.isNotEmpty || _uwebsiteController.text.isNotEmpty ||
                                                //     _ufacebookController.text.isNotEmpty || _ugithubController.text.isNotEmpty || _ulinkedinController.text.isNotEmpty ||
                                                //     _uinstagramController.text.isNotEmpty || _utwitterController.text.isNotEmpty) {
                                                //   Firestore.instance
                                                //       .collection("Users")
                                                //       .document(currentUser.uid)
                                                //       .setData({
                                                //     "uid": currentUser.uid,
                                                //     "fullname": _ufullnameController.text,
                                                //     "udesc": _udescController.text,
                                                //     "umobilenumber": _umobilenumberController.text,
                                                //     "ulocation": _ulocationController.text,
                                                //     "uemail": _uemailController.text,
                                                //     "uwebsite": _uwebsiteController.text,
                                                //     "ufacebook": _ufacebookController.text,
                                                //     "ugithub": _ugithubController.text,
                                                //     "ulinkedin": _ulinkedinController.text,
                                                //     "uinstagram": _uinstagramController.text,
                                                //     "utwitter": _utwitterController.text,
                                                //   })
                                                //       .then((result) => {
                                                //     print('successfully updated'),
                                                //     Navigator.pop(context),
                                                //   })
                                                //       .catchError((e) => {
                                                //     print(e),
                                                //     showDialog(context: context,
                                                //         child: AlertDialog(
                                                //           title: Text('Update something'),
                                                //         ))
                                                //   });
                                                //   _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Profile updated successfully!')));
                                                // }
                                              }
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20, right: 20),
                                          child: Column(
                                            children: <Widget>[
                                              CircleAvatar(
                                                maxRadius: 40,
                                                backgroundColor: Colors.black,
//                                              backgroundImage: AssetImage('asset/user.png'),
                                              ),
                                              SizedBox(height: 10,),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(labelText: 'Name', hintText: 'Will be displayed in profile'),
                                                keyboardType: TextInputType.text,
                                                // controller: _ufullnameController,
                                              ),
                                              TextField(
                                                autofocus: true,
                                                maxLength: 100,
                                                decoration: InputDecoration(labelText: 'Description', hintText: 'Ex. Flutter Developer'),
                                                // controller: _udescController,
                                              ),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(labelText: 'Mobile Number'),
                                                keyboardType: TextInputType.phone,
                                                // controller: _umobilenumberController,
                                              ),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(labelText: 'Location', hintText: 'Ex. Mumbai, India'),
                                                keyboardType: TextInputType.text,
                                                // controller: _ulocationController,
                                              ),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(labelText: 'Email'),
                                                keyboardType: TextInputType.emailAddress,
                                                // controller: _uemailController,
                                              ),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(labelText: 'Website URL'),
                                                keyboardType: TextInputType.url,
                                                // controller: _uwebsiteController,
                                              ),
                                              SizedBox(height: 20,),
                                              Text('Social Media Links', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                              SizedBox(height: 5,),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(prefixIcon: Image.asset('assets/facebook.png', scale: 1.6,), labelText: 'Facebook URL'),
                                                keyboardType: TextInputType.url,
                                                // controller: _ufacebookController,
                                              ),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(prefixIcon: Image.asset('assets/github.png', scale: 1.6,), labelText: 'Github URL'),
                                                keyboardType: TextInputType.url,
                                                // controller: _ugithubController,
                                              ),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(prefixIcon: Image.asset('assets/linkedin.png', scale: 1.6,), labelText: 'LinkedIn URL'),
                                                keyboardType: TextInputType.url,
                                                controller: _ulinkedinController,
                                              ),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(prefixIcon: Image.asset('assets/instagram.png', scale: 1.6,), labelText: 'Instagram URL'),
                                                keyboardType: TextInputType.url,
                                                controller: _uinstagramController,
                                              ),
                                              TextField(
                                                autofocus: true,
                                                decoration: InputDecoration(prefixIcon: Image.asset('assets/twitter.png', scale: 1.6,), labelText: 'Twitter URL'),
                                                keyboardType: TextInputType.url,
                                                controller: _utwitterController,
                                              ),
                                              SizedBox(height: 20,),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        child: Container(
                            height: 40.0, width: 200.0,
                            decoration: BoxDecoration(color: kThemeColor, borderRadius: BorderRadius.circular(10),),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.border_color, color: Colors.white,),
                                SizedBox(width: 10.0,),
                                Text('Edit Profile', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                SizedBox(width: 5.0,),
                              ],
                            )
                        ),
                      ),),
                      SizedBox(height: 20.0,),
                      FadeAnimation(0.7, GestureDetector(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => new UpdateDetails()));
                        },
                        child: Container(
                            height: 40.0, width: 200.0,
                            decoration: BoxDecoration(color: kThemeColor, borderRadius: BorderRadius.circular(10),),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.assignment_ind, color: Colors.white,),
                                SizedBox(width: 10.0,),
                                Text('Build your Resume', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),),
                                SizedBox(width: 5.0,),
                              ],
                            )
                        ),
                      ),),
                    ],
                  )
              )
              // SizedBox(height: 20),
              // CircleAvatar(
              //   minRadius: 70,
              //   maxRadius: 70,
              //   backgroundImage: AssetImage('images/benita.jpeg'),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(30),
              //   child: Column(
              //     children: <Widget>[
              //       const ListTile(
              //         leading: Icon(Icons.person, size: 30),
              //         title: Text(
              //             'Benita Rego',
              //             style: TextStyle(fontSize: 20.0)
              //         ),
              //       ),
              //       const ListTile(
              //         leading: Icon(Icons.phone, size: 30),
              //         title: Text(
              //             '+918757546467',
              //             style: TextStyle(fontSize: 20.0)
              //         ),
              //       ),
              //       const ListTile(
              //         leading: Icon(Icons.assignment, size: 30),
              //         title: Text(
              //             'Foodie',
              //             style: TextStyle(fontSize: 20.0)
              //         ),
              //       ),
              //       const ListTile(
              //         leading: Icon(Icons.fastfood, size: 30),
              //         title: Text(
              //             'French Toast',
              //             style: TextStyle(fontSize: 20.0)
              //         ),
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           OutlineButton(
              //             color: Colors.black,
              //             highlightColor: Colors.black,
              //             child: Text("Edit"),
              //             onPressed: () {
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => EditProfile()));
              //             },
              //           ),
              //         ],
              //       )
              //     ],
              //   )
              // )
            ],
          ),
        )
        // child: FutureBuilder(
        //   future: FirebaseAuth.instance.currentUser(),
        //   builder: (context, snapshot) {
        //     FirebaseUser firebaseUser = snapshot.data;
        //     return snapshot.hasData
        //         ? Container(
        //       color: Colors.white,
        //       width: MediaQuery.of(context).size.width,
        //       child: Column(
        //         // mainAxisAlignment: MainAxisAlignment.center,
        //         // crossAxisAlignment: CrossAxisAlignment.center,
        //         children: [
        //           SizedBox(height: 20),
        //           firebaseUser.photoUrl == null
        //               ? SizedBox(height: 0)
        //               : CircleAvatar(
        //             minRadius: 70,
        //             maxRadius: 70,
        //             backgroundImage: NetworkImage(firebaseUser.photoUrl),
        //           ),
        //           SizedBox(height: 20),
        //           Text("${firebaseUser.displayName}", style: TextStyle(fontSize: 20, color: Colors.black),),
        //           SizedBox(height: 20),
        //         ],
        //       ),
        //     )
        //         : Center(
        //         child: CircularProgressIndicator(backgroundColor: kThemeColor,)
        //     );
        //   },
        // ),
      ),
    );
  }
}

// Text("Upload an image",
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontFamily: "Poppins-Medium",
// // fontSize: ScreenUtil().setSp(30)
// fontSize: 15,
// )),
// RaisedButton(
// color: Colors.white,
// onPressed: () {
// _showDialog(context);
// },
// child: Text("Select Image", style: TextStyle(
// fontSize: 12,
// fontWeight: FontWeight.w600,
// )),
// ),

class ProfileCard extends StatelessWidget {
  // ProfileCard({@required this.ufullname, this.udesc, this.umobilenumber, this.ulocation, this.uemail,
  //   this.uwebsite, this.ufacebook, this.ugithub, this.ulinkedin, this.uinstagram, this.utwitter, this.uimg});

  // final ufullname;
  // final udesc;
  // final umobilenumber;
  // final ulocation;
  // final uemail;
  // final uwebsite;
  // final ufacebook;
  // final ugithub;
  // final ulinkedin;
  // final uinstagram;
  // final utwitter;
  // final uimg;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 80),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Container(
                  width: 280.0,
                  decoration: BoxDecoration(
                    color: kContainerColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    width: 270.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: kContainerColor,
                      boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 10.0,),],),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 50.0,),
                            Text("Benita Rego", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),),
                            SizedBox(height: 10.0,),
                            Text("Flutter Developer", textAlign: TextAlign.center, style: TextStyle(color: kThemeColor, fontWeight: FontWeight.bold, fontSize: 16.0),),
                            SizedBox(height: 20.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.phone, size: 18.0, color: Colors.black),
                                    SizedBox(width: 5.0,),
                                    Text("9893846576", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16.0),)
                                  ],
                                ),
                                SizedBox(width: 10.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.location_on, size: 18.0, color: Colors.black,),
                                    SizedBox(width: 5.0,),
                                    Text("Mumbai, India", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16.0),)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.email, size: 18.0, color: Colors.black,),
                                SizedBox(width: 5.0,),
                                Text("benita@gmail.com", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16.0),)
                              ],
                            ),
                            SizedBox(height: 10.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.attach_file, size: 18.0, color: Colors.black,),
                                SizedBox(width: 5.0,),
                                Text("https://www.flutter.com", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16.0),)
                              ],
                            ),
                            SizedBox(height: 10.0,),
//                            (ufacebook.toString().isEmpty || ugithub.toString().isEmpty || ulinkedin.toString().isEmpty || uinstagram.toString().isEmpty || utwitter.toString().isEmpty) ? Container(height: 0, width: 0) :
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(onPressed: () {}, icon: Image.asset('assets/facebook.png')),
                                IconButton(onPressed: () {}, icon: Image.asset('assets/github.png')),
                                IconButton(onPressed: () {}, icon: Image.asset('assets/linkedin.png')),
                                IconButton(onPressed: () {}, icon: Image.asset('assets/instagram.png')),
                                IconButton(onPressed: () {}, icon: Image.asset('assets/twitter.png')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                CircleAvatar(
                  minRadius: 70,
                  maxRadius: 70,
                  backgroundImage: AssetImage('images/benita.jpeg'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}