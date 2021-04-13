import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  Container createStat(Container c) {
    Container stat = new Container(
      constraints: BoxConstraints(
        maxWidth: 100.0,
        maxHeight: 30.0,
      ),
      decoration: BoxDecoration(
        //color: Colors.grey,
        border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
    return stat;
  }

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
    Container stat = createStat(Container());
    Container gameStatus = Container(
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            border: Border.all(color: Colors.grey /*[800]*/, width: 1.5),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ), // set rounded corner radius
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(55.0),
                    ),
                  ),
                  child: CircleAvatar(
                    child: Image(
                      image: AssetImage('assets/profile.png'),
                    ),
                    radius: 55.0,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    stat,
                    SizedBox(
                      height: 20.0,
                    ),
                    stat,
                  ],
                ),
                SizedBox(
                  width: 12.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    stat,
                    SizedBox(
                      height: 20.0,
                    ),
                    stat,
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

    Widget notification = Container(
      height: 40.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.yellow,
      ),
      child: Center(
        child: Text(
          "Notifications",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Gloria',
            color: Colors.white,
          ),
        ),
      ),
    );

    Widget notificationArea = Container(
      margin: EdgeInsets.fromLTRB(20.0, 90.0, 20.0, 0.0),
      constraints: BoxConstraints(
        minHeight: 40.0,
        maxHeight: 200.0,
        minWidth: MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 3.0,
            spreadRadius: 1.0,
            offset: Offset(2.0, 2.0),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 40.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                "Notifications",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Gloria',
                  color: Colors.white,
                ),
              ),
            ),
          ),

          notification,
        ],
      ),
    );

    /*Material(
      elevation: 10,
      child: Container(
        margin: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
        constraints: BoxConstraints(
          maxHeight: 200.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
    );*/

    return Scaffold(
      //backgroundColor: Color(0xFFF3EFE4),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          elevation: 3.0,
          backgroundColor: Colors.white,
          toolbarHeight: 60.0,
          title: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
      body: Column(
        children: [
          gameStatus,
          notificationArea,
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
        alignment: Alignment.topCenter,
        height: 112.0,
        decoration: new BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.vertical(
            top: Radius.elliptical(
              MediaQuery.of(context).size.width,
              240.0,
            ),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              child: FloatingActionButton(
                child: Icon(Icons.query_stats, color: Colors.yellowAccent,),
                onPressed: () {
                  print('Productivity');
                },
                tooltip: "Productivity",
                backgroundColor: Colors.black,
              ),
              right: 0,
              left: -MediaQuery.of(context).size.width * 0.6875,
              bottom: 50,
            ),
            Positioned(
              child: FloatingActionButton(
                child: Icon(Icons.menu_book, color: Colors.yellowAccent,),
                onPressed: () {
                  print('Journal');
                  print('${MediaQuery.of(context).size.width}');
                },
                tooltip: "Journal",
                backgroundColor: Colors.black,
              ),
              right: 0,
              left: 0,
              bottom: 80,
            ),
            Positioned(
              child: FloatingActionButton(
                //mini: true,
                child: Icon(Icons.list_alt, color: Colors.yellowAccent,),
                onPressed: () {
                  print('Todo list');
                },
                tooltip: "Todo list",
                backgroundColor: Colors.black,
              ),
              right: 0,
              left: MediaQuery.of(context).size.width * 0.6875,
              bottom: 50,
            ), /**/
          ],
        ),
      ),
    );
  }
}

class Journal extends StatefulWidget {
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
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
        /*border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5.0),
          //bottom: Radius.zero,
        ),*/
      ),
      child: Scrollbar(
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
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
      //foregroundPainter: NotebookPage(),
      child: contentField,
    );

    //TextBox w = TextBox.fromLTRBD(left, top, right, bottom, direction)

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
      body: Padding(
        child: contentField,
        padding: EdgeInsets.all(0.0),
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
