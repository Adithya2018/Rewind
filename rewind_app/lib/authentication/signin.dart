import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/app_data/app_data_state.dart';
import 'package:rewind_app/services/auth_ctrl.dart';

class SignInWithEmail extends StatefulWidget {
  final Function? toggleView;
  SignInWithEmail({this.toggleView});
  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _pwd = "";

  FocusNode? _n1;
  FocusNode? _n2;
  FocusNode? _n3;

  @override
  void initState() {
    super.initState();
    _n1 = FocusNode();
    _n2 = FocusNode();
    _n3 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _n1!.dispose();
    _n2!.dispose();
    _n3!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailPhNoField = Container(
      width: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        focusNode: _n1,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (term) {
          _n1!.unfocus();
          FocusScope.of(context).requestFocus(_n2);
        },
        onChanged: (val) {
          setState(() {
            _email = val;
          });
        },
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (val) {
          String? s;
          if (val!.isEmpty) {
            s = "Email cannot be empty";
          }
          return s;
        },
      ),
    );

    final pwdField = Container(
      width: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        focusNode: _n2,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (term) {
          _n2!.unfocus();
          FocusScope.of(context).requestFocus(_n3);
        },
        onChanged: (val) {
          setState(() {
            _pwd = val;
          });
        },
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Password",
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (val) {
          String? s;
          if (val!.isEmpty) {
            s = "Password cannot be empty";
          }
          return s;
        },
      ),
    );

    // name was _invalidOrAccExists
    Future<void> _credentialErrMsg({String? msg}) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Error "),
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
              ],
            ),
            content: Container(
              child: Text(
                msg!,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Continue"),
              ),
            ],
          );
        },
      );
    }

    final signInButton = Container(
      width: 200,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.blue,
        child: MaterialButton(
          focusNode: _n3,
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              print("valid");
              dynamic result = await _auth.signInWithEmailAndPwd(_email, _pwd);
              if (result.runtimeType == FirebaseAuthException) {
                await _credentialErrMsg(msg: result.message);
              } else {
                print(result);
                AppDataCommon.of(context).setUserData(result);
                Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).pushNamed('/');
              }
            }
          },
          child: Text(
            "Sign in",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.blue,
              size: 30.0,
            ),
            tooltip: 'Navigation menu',
            onPressed: () => print("Nav menu"),
          ),
          title: Text(
            'Rewind App', // Page',
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 22.0,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person_add_alt_1,
                color: Colors.blue,
                size: 30.0,
              ),
              tooltip: 'Register',
              onPressed: () {
                print('Create an account w/ Email');
                widget.toggleView!();
              },
            ),
          ],
        ),
      ),
      body: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFF1BDFE),
              Color(0xFFBFF5F9),
            ],
          ),
        ),
        child: Scrollbar(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 30.0),
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sign In",
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          emailPhNoField,
                          SizedBox(
                            height: 40,
                          ),
                          pwdField,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    signInButton,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
