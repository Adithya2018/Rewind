import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/models/journal_page.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class EditJournalPage extends StatefulWidget {
  final JournalPage journalPage;
  final bool editMode;
  EditJournalPage({@required this.journalPage, @required this.editMode});
  @override
  _EditJournalPageState createState() => _EditJournalPageState();
}

class _EditJournalPageState extends State<EditJournalPage> {
  JournalPage journalPage;
  TextEditingController titleCtrl;
  TextEditingController descriptionCtrl;

  @override
  void initState() {
    super.initState();
    journalPage = JournalPage.fromJournalPage(widget.journalPage);
    titleCtrl = TextEditingController(text: journalPage.title);
    descriptionCtrl = TextEditingController(text: journalPage.content);
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateAndTimeFormat dtf = DateAndTimeFormat();

  @override
  Widget build(BuildContext context) {
    Container titleArea = Container(
      margin: EdgeInsets.only(
        top: 0.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
          //bottom: Radius.zero,
        ),
      ),
      child: TextField(
        controller: titleCtrl,
        textAlign: TextAlign.left,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.blueGrey,
        style: TextStyle(
          fontFamily: 'Gloria',
          fontSize: 21,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15.0, 0.0, 20.0, 0.0),
          hintText: "Title",
          border: InputBorder.none,
        ),
      ),
    );


    DateTime now = DateTime.now();
    int hour = now.hour;
    int minute = now.minute;
    Container dateTime = Container(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
      alignment: Alignment.centerRight,
      child: Text(
        "${dtf.formatTime(TimeOfDay(
          hour: hour,
          minute: minute,
        ))} ${dtf.formatDate(now)}",
        textAlign: TextAlign.end,
        style: GoogleFonts.gloriaHallelujah(
          fontSize: 14,
        ),
      ),
    );

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
          controller: descriptionCtrl,
          expands: true,
          maxLines: null,
          minLines: null,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.justify,
          textAlignVertical: TextAlignVertical.top,
          cursorColor: Colors.blueGrey,
          style: GoogleFonts.gloriaHallelujah(
            fontSize: 16,
            color: Color(0xFF0938BC),
          ),
          decoration: InputDecoration(
            hintText: "Write something",
            contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
            border: InputBorder.none,
          ),
        ),
      ),
    );

    Future<void> showErrorMessage({String title, String msg}) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MaterialCommunityIcons.alert,
                  color: Colors.red,
                  size: 35.0,
                ),
                Text(
                  title ?? "Try again",
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            content: Container(
              child: Text(
                msg,
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 16,
                ),
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

    return Scaffold(
      backgroundColor: Colors.white,
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
                journalPage.fav ? Icons.favorite : Icons.favorite_outline,
                color: Colors.pinkAccent,
                size: 30.0,
              ),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              tooltip:
                  '${journalPage.fav ? "Remove from" : "Add to"} favorites',
              onPressed: () {
                setState(() {
                  journalPage.fav = !journalPage.fav;
                });
                print("more options");
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
                size: 30.0,
              ),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              tooltip: 'Delete',
              onPressed: () {
                print("delete page");
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          dateTime,
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
                      if (titleCtrl.text.isEmpty) {
                        await showErrorMessage(
                          msg: "Title cannot be empty",
                        );
                        return;
                      }
                      journalPage.title = titleCtrl.text;
                      journalPage.content = descriptionCtrl.text;
                      journalPage.created = journalPage.createdDateTime;
                      Navigator.pop(context, journalPage);
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
                      Navigator.pop(context, null);
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
