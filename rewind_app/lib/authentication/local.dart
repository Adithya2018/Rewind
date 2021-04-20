import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth extends StatefulWidget {
  @override
  _LocalAuthState createState() => _LocalAuthState();
}

class _LocalAuthState extends State<LocalAuth> {
  LocalAuthentication localAuth = LocalAuthentication();
  Future<List<BiometricType>> getBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await localAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) {
      return null;
    }
    print(listOfBiometrics);
    return listOfBiometrics;
  }

  Future<bool> checkUser() async {
    bool canAuthenticate;
    try {
        canAuthenticate = await localAuth
          .authenticate(
        localizedReason: 'Use fingerprint to unlock',
        biometricOnly: true,
      );

    } on PlatformException catch (e) {
      print("an exception occurred");
      print(e.message);
    }
    if (!mounted) {
      return null;
    }
    print("can authenticate=$canAuthenticate");
    return canAuthenticate;
  }

  List<BiometricType> authType;
  @override
  Widget build(BuildContext context) {
    Future<List<BiometricType>> listOfBiometrics = getBiometricTypes();
    //var didAuthenticate = checkUser();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 3.0,
          backgroundColor: Colors.cyan[300],
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 30.0,
            ),
            tooltip: 'Navigation menu',
            onPressed: () => print("nav menu"),
          ),
          title: Text(
            'Authenticate', // Page',
            style: TextStyle(
              color: Colors.grey[100],
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          actions: <Widget>[
            /*IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 30.0,
              ),
              tooltip: 'Add',
              onPressed: () {
                Navigator.of(context).pushNamed('/reg');
              },
            ),*/
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 30.0,
              ),
              tooltip: 'Refresh',
              onPressed: () {
                Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).pushNamed('/');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.lightBlue,
              ),
            ),
            SizedBox(
              height: 20,
            ),*/
            IconButton(
              iconSize: 48.0,
              onPressed: () {
                print("auth button");
              },
              icon: Icon(
                Icons.lock_open,
              ),
            ),
            TextButton(
              onPressed: () {
                print("auth button");
                checkUser();
              },
              child: Text(
                "Unlock",
                style: TextStyle(
                  fontFamily: 'Monospace',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
