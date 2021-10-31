import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleMessageScaffold extends StatelessWidget {
  final String? message;
  final IconData? iconData;
  const SimpleMessageScaffold({this.message,this.iconData, Key? key}) : super(key: key);

  Scaffold messageScaffold(String message, IconData iconData) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: Colors.yellow,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              message,
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/**/