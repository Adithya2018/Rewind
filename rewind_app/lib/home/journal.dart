import 'dart:ui';
import 'package:flutter/material.dart';

class NotebookPageLayout extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pageColor = Paint()..color = Color(0xFFF3EFE4);
    var pageSpace = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(5.0),
    );
    RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(8.0),
    );
    canvas.drawRRect(pageSpace, pageColor);

    //Step 2
    final paintWhite = Paint()..color = Colors.white;
    var rrectWhite = RRect.fromLTRBR(
      5,
      0,
      size.width,
      size.height,
      Radius.circular(8.0),
    );
    canvas.drawRRect(rrectWhite, paintWhite);

    final paintDarkgrey = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 1.0;
    double lineHeight = 35.0;
    canvas.drawLine(
      Offset(0, lineHeight),
      Offset(size.width, lineHeight),
      paintDarkgrey,
    );
    canvas.drawLine(
      Offset(0, lineHeight*2),
      Offset(size.width, lineHeight*2),
      paintDarkgrey,
    );
    TextStyle contentTextStyle = TextStyle(
      fontFamily: 'Kristi',
      fontSize: 23,
      color: Color(0xFF0938BC),
    );
    final ParagraphBuilder paragraphBuilder = ParagraphBuilder(
      ParagraphStyle(
        fontSize: contentTextStyle.fontSize,
        fontFamily: contentTextStyle.fontFamily,
        fontStyle: contentTextStyle.fontStyle,
        fontWeight: contentTextStyle.fontWeight,
        textAlign: TextAlign.justify,
      ),
    )
      ..pushStyle(contentTextStyle.getTextStyle())
      ..addText(
          "Write somethingWrite somethingWrite somethingWrite somethingWrite somethingWrite somethingWrite something");
    final Paragraph paragraph = paragraphBuilder.build()
      ..layout(
        ParagraphConstraints(width: size.width - 12.0 - 12.0),
      );
    canvas.drawParagraph(paragraph, const Offset(12.0, 12.0));
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 23,
      fontFamily: 'Gloria',
    );
    final textSpan = TextSpan(
      mouseCursor: MouseCursor.defer,
      text: 'Hello, world.',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final offset1 = Offset(50, 100);
    final offset2 = Offset(50, 123);

    textPainter.paint(canvas, offset1);
    textPainter.paint(canvas, offset2);
  }

  @override
  bool shouldRepaint(NotebookPageLayout oldDelegate) {
    return true;
  }

  @override
  bool shouldRebuildSemantics(NotebookPageLayout oldDelegate) {
    return true;
  }
}

class JournalTemp extends StatefulWidget {
  @override
  _JournalTempState createState() => _JournalTempState();
}

class _JournalTempState extends State<JournalTemp> {
  String titleText = "dfv";
  bool titleInViewMode = true;
  bool contentInViewMode = true;
  void changeTitleMode() {
    setState(() {
      titleInViewMode = !titleInViewMode;
    });
  }

  void changeContentMode() {
    setState(() {
      contentInViewMode = !contentInViewMode;
    });
  }

  FocusNode titleFocus;

  @override
  void initState() {
    super.initState();
    titleFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    titleFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextField titleField = TextField(
      enabled: titleInViewMode,
      focusNode: titleFocus,
      textAlign: TextAlign.left,
      cursorColor: Colors.white,
      style: TextStyle(
        fontFamily: 'Gloria',
        //fontStyle: FontStyle.italic,
        fontSize: 18,
      ),
      //onEditingComplete: () => changeTitleMode(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
        //labelText: "Title",
        hintText: "Title",
        //hintText: "Title",
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(5.0),
        ),
        /**/ border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        /*suffixIcon: ElevatedButton(
          child: Icon(
            Icons.check_sharp,
          ),
          onPressed: () {
            titleFocus.unfocus();
          },
          style: ButtonStyle(),
        ),*/
      ),
    );

    /**/ Container pageTitleArea = Container(
      alignment: Alignment.centerLeft,
      child: titleField,
      constraints: BoxConstraints(
        maxHeight: 40.0,
      ),
      //width: double.maxFinite,
    );

    Container contentField = Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Color(0xFFF3EFE4),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
          //bottom: Radius.zero,
        ),
      ),
      child: Scrollbar(
        child: TextField(
          enabled: contentInViewMode,
          expands: true,
          maxLines: null,
          minLines: null,
          keyboardType: TextInputType.multiline,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontFamily: 'Gloria',
            fontSize: 18,
            color: Color(0xFF0938BC),
          ),
          decoration: InputDecoration(
            hintText: "Write something",
            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
          ),
        ),
      ),
    );

    CustomPaint notebookPageLayout = CustomPaint(
      foregroundPainter: NotebookPageLayout(),
      child: contentField,
    );

    Container contentFieldTemp = Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Color(0xFFF3EFE4),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
          //bottom: Radius.zero,
        ),
      ),
      child: notebookPageLayout,
    );

    return Scaffold(
      //backgroundColor: Color(0xFFF3EFE4),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          elevation: 3.0,
          backgroundColor: Colors.cyan[300],
          toolbarHeight: 60.0,
          title: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pageTitleArea,
              Row(
                children: [
                  SizedBox(
                    width: 7.0,
                  ),
                  Text(
                    "10 April 2021, 7:45 pm",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert_sharp,
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
      body: contentFieldTemp,
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.blue,
              ),
              onPressed: () {
                changeContentMode();
                print("edit button");
              },
            ),
            label: "Not saved",
            tooltip: "Read mode",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                contentInViewMode ? Icons.visibility : Icons.edit,
                color: Colors.blue,
              ),
              onPressed: () {
                changeTitleMode();
                changeContentMode();
                print("edit button");
              },
            ),
            label: "${contentInViewMode ? "View" : "Edit"} mode",
            tooltip: "Read mode",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              onPressed: () {
                print("cancel button");
              },
            ),
            label: "Cancel",
            tooltip: "Read mode",
          ),
        ],
      ),
    );
  }
}
/*
    Container titleArea = Container(
      child: TextField(
        textInputAction: TextInputAction.next,
        onChanged: (val) {
          setState(() {});
        },
        cursorColor: Colors.white,
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: "Password",
          //hintText: "Password",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(5.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
            //borderRadius: BorderRadius.circular(5.0),
          ),
          /* suffixIcon: ElevatedButton(
            child: Icon(
              Icons.check_sharp,
            ),
            onPressed: () {
              titleFocus.unfocus();
            },
            style: ButtonStyle(),
          ),*/
        ),
      ),
    );*/
