import 'package:flutter/material.dart';
import 'package:rewind_app/authentication/register.dart';
import 'package:rewind_app/authentication/signin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn
        ? SignInWithEmail(toggleView: toggleView)
        : CreateAccWithEmail(toggleView: toggleView);
  }
}
