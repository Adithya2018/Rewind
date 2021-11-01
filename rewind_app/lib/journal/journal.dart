import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/models/day_and_time.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class JournalTemp extends StatefulWidget {
  @override
  _JournalTempState createState() => _JournalTempState();
}

class _JournalTempState extends State<JournalTemp> {
  // String titleText = "dfv";

  FocusNode? titleFocus;

  @override
  void initState() {
    super.initState();
    titleFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    titleFocus!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Container titleArea = Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
          //bottom: Radius.zero,
        ),
      ),
      child: TextField(
        // enabled: titleInViewMode,
        focusNode: titleFocus,
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.blueGrey,
        style: TextStyle(
          fontFamily: 'Gloria',
          fontSize: 18,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
          hintText: "Title",
          border: InputBorder.none,
        ),
      ),
    );

    /*DateAndTimeFormat dtf = DateAndTimeFormat();

    Container dateTime = Container(
      child: Text("${dtf.formatDate(DateTime.now())}"),
    );*/

    Container contentArea = Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
          //bottom: Radius.zero,
        ),
      ),
      child: Scrollbar(
        child: TextField(
          expands: true,
          maxLines: null,
          minLines: null,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.justify,
          cursorColor: Colors.blueGrey,
          style: TextStyle(
            fontFamily: 'Gloria',
            fontSize: 18,
            color: Color(0xFF0938BC),
          ),
          decoration: InputDecoration(
            hintText: "Write something",
            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          toolbarHeight: 60.0,
          title: Text(
            "Journal",
            textAlign: TextAlign.left,
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert_sharp,
                color: Colors.black,
                size: 30.0,
              ),
              tooltip: 'Refresh',
              onPressed: () {
                print("more options");
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          titleArea,
          Expanded(
            child: contentArea,
          ),
        ],
      ),
      /*persistentFooterButtons: [
        IconButton(
          alignment: Alignment.centerLeft,
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.add,
          ),
        ),
      ],*/
      bottomNavigationBar: Container(
        height: 70.0,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              offset: Offset(0.0, -1.0),
              blurRadius: 7.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Center(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextButton(
                    child: Text(
                      "Save",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      print("Save");
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextButton(
                    child: Text(
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      print("Cancel");
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
