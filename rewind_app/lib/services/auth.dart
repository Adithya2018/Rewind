import 'package:rewind_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';

/*
* sign-in and sign-out service
**/
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserData userFromDB(User user) {
    return (user == null)
        ? null
        : UserData(
            uid: user.uid,
            displayName: user.displayName,
            email: user.email,
          );
  }

  // determine whether user is signed in or signed out
  Stream<UserData> get user {
    return _auth.authStateChanges().map(userFromDB);
  }

  // anonymous sign-in
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return userFromDB(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // email and password sign-in
  Future signInWithEmailAndPwd(String email, String pwd) async {
    UserCredential result;
    try {
      result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      User user = result.user;
      print(user);
      return userFromDB(user);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      print("Error!!!");
      return e;
    } on Exception catch (e) {
      print("Unknown error occurred");
      print(e.toString());
      return e;
    }
  }

  // register with email and password
  Future reqNewAccountWithEmail(String email, String pwd) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pwd,
      );
      User user = result.user;
      return userFromDB(user);
    } catch (e) {
      print(e.toString());
      print("user exists");
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
