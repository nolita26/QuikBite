// import 'package:crescendo_hack/services/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   //create user obj based on FirebaseUser
//   User _userFromFirebaseUser(FirebaseUser user) {
//     return user != null ? User(uid: user.uid) : null;
//   }
//
//   //auth change user stream
//   Stream<User> get user {
//     return _auth.onAuthStateChanged
//         .map((FirebaseUser user) => _userFromFirebaseUser(user));
//   }
//
//
//   //sign in with email and password
//   Future signInWithEmailAndPassword(String email, String password) async {
//     try {
//       AuthResult result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       FirebaseUser user = result.user;
//       return _userFromFirebaseUser(user);
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   //register with email and password
//   Future registerWithEmailAndPassword(String email, String password) async {
//     try {
//       AuthResult result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       FirebaseUser user = result.user;
//       return _userFromFirebaseUser(user);
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//   //sign out
//   Future signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }
//
//
// }