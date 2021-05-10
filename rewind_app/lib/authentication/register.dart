import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/services/auth.dart';

class CreateAccWithEmail extends StatefulWidget {
  final Function toggleView;
  CreateAccWithEmail({this.toggleView});
  @override
  _CreateAccWithEmailState createState() => _CreateAccWithEmailState();
}

class _CreateAccWithEmailState extends State<CreateAccWithEmail> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final AuthService _auth = AuthService();
  //String error = "";
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _pwd = "";
  TextEditingController _pwdFieldController = new TextEditingController();
  String _confPwd = "";

  FocusNode _n1;
  FocusNode _n2;
  FocusNode _n3;

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
    _n1.dispose();
    _n2.dispose();
    _n3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = Container(
      width: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        focusNode: _n1,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (term) {
          _n1.unfocus();
          FocusScope.of(context).requestFocus(_n2);
        },
        style: style,
        onChanged: (val) {
          setState(() {
            _email = val;
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (val) {
          String s;
          if (val.isEmpty) {
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
        controller: _pwdFieldController,
        focusNode: _n2,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (term) {
          _n2.unfocus();
          FocusScope.of(context).requestFocus(_n3);
        },
        obscureText: true,
        style: style,
        onChanged: (val) {
          setState(() {
            _pwd = val;
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Password",
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (val) {
          String s;
          if (val.isEmpty) {
            s = "Password cannot be empty";
          } else if (val.length < 8) {
            s = "Password must be at least 8 characters long";
          }
          return s;
        },
      ),
    );

    final confPwdField = Container(
      width: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        focusNode: _n3,
        obscureText: true,
        style: style,
        onFieldSubmitted: (val) {},
        onChanged: (val) {
          setState(() {
            _confPwd = val;
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Re-type password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (val) {
          String s;
          if (val.isEmpty) {
            s = "Password cannot be empty";
          } else if (val.length < 8) {
            s = "Password must be at least 8 characters long";
          } else if (_pwd != _confPwd) {
            s = "Passwords do not match";
          }
          return s;
        },
      ),
    );

    Future<void> _invalidOrAccExists() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Row(
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
                "Used or invalid e-mail address",
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

    final submitButton = Container(
      width: 200,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.blue,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          onPressed: () async {
            print("Email: $_email");
            print("Password: $_pwd");
            print("Re-typed password: $_confPwd");
            if (_formKey.currentState.validate()) {
              dynamic result = await _auth.reqNewAccountWithEmail(
                _email,
                _pwd,
              );
              if (result == null) {
                await _invalidOrAccExists();
              } else {
                Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).pushNamed('/');
              }
            }
          },
          child: Text(
            "Next",
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
                Icons.login,
                color: Colors.blue,
                size: 30.0,
              ),
              tooltip: 'Sign-in options',
              onPressed: () {
                print("Sign In w/ Email");
                widget.toggleView();
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
            shrinkWrap: true,
            children: [
              Container(
                alignment: Alignment.center,
                width: 600,
                margin: EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sign Up",
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
                          emailField,
                          SizedBox(
                            height: 40,
                          ),
                          pwdField,
                          SizedBox(
                            height: 40,
                          ),
                          confPwdField,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    submitButton,
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
