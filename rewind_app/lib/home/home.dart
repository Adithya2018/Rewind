import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username;
  int playerLevel;
  int xp;
  int health;
  int trophies;
  Container createStatContainer(
    String label, {
    IconData statIconData,
    Color iconColor,
    int statCurrent,
    int statMax,
  }) {
    Container stat = new Container(
      //height: 36.0,
      decoration: BoxDecoration(
        // color: Color(0xFFB2E5E3),
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0.0, 3.0, 12.0, 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.fromLTRB(4.5, 0.0, 3.5, 0.0),
              iconSize: 22.0,
              color: Colors.white,
              onPressed: () {
                print(label);
              },
              tooltip: "$statCurrent/$statMax",
              icon: Icon(
                statIconData,
                color: iconColor,
                size: 22,
              ),
            ),
            /*Icon(
              statIconData,
              size: 20,
              color: iconColor,
            ),*/

            /* Expanded(
              child: Container(),
            ),*/
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    label,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 5.0,
                    ),
                    color: Colors.white,
                    /*decoration: BoxDecoration(
                      color: Colors.white,
                    ),*/
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              color: Colors.red[600],
                            ),
                          ),
                          flex: statCurrent,
                        ),
                        Expanded(
                          child: /*SizedBox(),*/ Container(
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              color: Colors.blueGrey[100],
                            ),
                          ),
                          flex: statMax - statCurrent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    return stat;
  }

  double getScWidth() {
    return MediaQuery.of(context).size.width;
  }

  DateTime now;

  @override
  void initState() {
    super.initState();
    initializeGameInfo();
  }

  Future<void> initializeGameInfo() async {
    final SharedPreferences prefs = await this._prefs;
    playerLevel= !prefs.containsKey("playerLevel")?1:prefs.getInt("playerLevel");
    health= !prefs.containsKey("health")?1:prefs.getInt("health");
    trophies= !prefs.containsKey("trophies")?1:prefs.getInt("trophies");
    prefs.setInt("playerLevel", playerLevel).then((bool success) {
      print("playerLevel set? success=$success");
      return playerLevel;
    });
    prefs.setInt("health", health).then((bool success) {
      print("health set? success=$success");
      return health;
    });
    prefs.setInt("trophies", trophies).then((bool success) {
      print("trophies set? success=$success");
      return trophies;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  /*late*/ Future<int> _counter;
  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await this._prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    prefs.getKeys();
    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Container health = createStatContainer(
      "Health",
      statIconData: Icons.health_and_safety,
      iconColor: Colors.red[900],
      // iconColor: Color(0xffbb0a1e),
      statCurrent: 8,
      statMax: 10,
    );
    Container trophies = createStatContainer(
      "Trophies",
      statIconData: MaterialCommunityIcons.trophy,
      // iconColor: Color(0xFFD4AF37),
      iconColor: Colors.yellow[800],
      statCurrent: 60,
      statMax: 100,
    );
    Container xp = createStatContainer(
      "XP",
      statIconData: MaterialCommunityIcons.star,
      // iconColor: Color(0xFFD4AF37),
      iconColor: Colors.yellow[600],
      statCurrent: 700,
      statMax: 1000,
    );
    playerLevel = 12;
    Container gameStatus = Container(
      height: 130,
      // color: Color(0xFF174858),
      color: Colors.black,
      constraints: BoxConstraints(
        maxWidth: getScWidth(),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15.0,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(45.0),
              ),
            ),
            child: CircleAvatar(
              child: Image(
                image: AssetImage('assets/profile.png'),
              ),
              radius: 45.0,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Level $playerLevel",
                  style: GoogleFonts.gloriaHallelujah(
                      color: Colors.white, fontSize: 13),
                ),
                xp,
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: health,
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Expanded(
                      child: trophies,
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.0,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
        ],
      ),
    );
    Container getMoodStatBar({
      int current,
      String day,
      bool done,
    }) {
      int max = 100;
      Icon check;
      if (done == null) {
        check = Icon(
          MaterialCommunityIcons.help,
          size: 14.0,
        );
      } else {
        check = Icon(
          done ? MaterialCommunityIcons.check : MaterialCommunityIcons.cancel,
          color: done ? Colors.green : Colors.red,
          size: 14.0,
        );
      }
      Container statBar = new Container(
        constraints: BoxConstraints(
          maxWidth: 4.0,
          maxHeight: 200.0,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Expanded(
              flex: max - current,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              flex: current,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      );
      Container result = new Container(
        child: Column(
          children: [
            Text(
              "$current%",
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 9,
              ),
            ),
            Expanded(
              child: statBar,
            ),
            SizedBox(
              height: 3.0,
            ),
            check,
            Text(
              day,
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 9,
              ),
            ),
          ],
        ),
      );
      return result;
    }

    Widget streakGraph = Container(
      margin: EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 0.0),
      constraints: BoxConstraints(
        minHeight: 40.0,
        maxHeight: 200.0,
        minWidth: MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFB2E5E3),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            blurRadius: 3.0,
            spreadRadius: 1.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 45.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
            ),
            child: Center(
              child: Text(
                "Streak graph",
                textAlign: TextAlign.left,
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            height: 155.0,
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /**/ getMoodStatBar(
                  current: 70,
                  day: "M",
                ),
                getMoodStatBar(
                  current: 64,
                  day: "T",
                  done: true,
                ),
                getMoodStatBar(
                  current: 80,
                  day: "W",
                  done: false,
                ),
                getMoodStatBar(
                  current: 70,
                  day: "T",
                ),
                getMoodStatBar(
                  current: 64,
                  day: "F",
                ),
                getMoodStatBar(
                  current: 80,
                  day: "S",
                ),
                getMoodStatBar(
                  current: 90,
                  day: "Today",
                ),
              ],
            ),
          ),
          //notification,
        ],
      ),
    );

    Widget notification = Container(
      margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
      height: 100.0,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "New challenge!",
            textAlign: TextAlign.left,
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 14,
              color: Colors.white,
            ), /*TextStyle(
              fontSize: 14,
              fontFamily: 'Gloria',
              color: Colors.white,
            ),*/
          ),
        ],
      ),
    );

    Widget notificationArea = Container(
      margin: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
      constraints: BoxConstraints(
        minHeight: 100.0,
        maxHeight: 200.0,
        minWidth: MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        //border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
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
            height: 45.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
            ),
            child: Center(
              child: Text(
                "Notifications",
                textAlign: TextAlign.left,
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            height: 155.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    notification,
                    notification,
                    SizedBox(
                      height: 5.0,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: null,
          elevation: 0.0,
          backgroundColor: Colors.white,
          toolbarHeight: 60.0,
          title: Row(
            children: [
              Text(
                "Rewind",
                textAlign: TextAlign.left,
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 22,
                  color: Colors.black,
                ),
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
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              gameStatus,
              streakGraph,
              notificationArea,
            ],
          ),
        ),
      ),
      drawer: Container(
        padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFB2E5E3),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(45.0),
                ),
              ),
              child: CircleAvatar(
                child: Image(
                  image: AssetImage('assets/profile.png'),
                ),
                radius: 45.0,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
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
                  child: IconButton(
                    icon: Icon(
                      Icons.query_stats,
                      // color: Colors.green,
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: () {
                      print("Productivity");
                      Navigator.of(context).pushNamed('/ach');
                    },
                    tooltip: "Productivity",
                  ),
                ),
                flex: 1,
              ),
              // Spacer(),
              Expanded(
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.menu_book,
                      // color: Colors.orange[700],
                      // color: Colors.blueGrey[500],
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: () async {
                      print("Journal");
                      print(MediaQuery.of(context).size.width);
                      Navigator.of(context).pushNamed('/jou');
                      final SharedPreferences prefs = await _prefs;
                      final int counter = (prefs.getInt('counter') ?? 0) + 1;
                      //prefs.clear();
                      /*setState(() {
                        _counter = prefs.setInt("counter", 0).then((bool success) {
                          /**/print("$counter");
                          print("${prefs.getKeys()}");
                          return counter;
                        });
                        _counter = prefs.setInt("x1 level", 0).then((bool success) {
                          /**/print("$counter");
                          print("${prefs.getKeys()}");
                          return counter;
                        });
                      });*/
                      //await prefs.clear();
                      prefs.getKeys().forEach((key) {
                        print("$key");
                      });

                    },
                    tooltip: "Journal",
                  ),
                  //alignment: Alignment.center,
                ),
                flex: 2,
              ),
              // Spacer(),
              Expanded(
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.list_alt,
                      // color: Colors.blue[800],
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: () {
                      print("Todo list");
                      Navigator.of(context).pushNamed('/tdl');
                    },
                    tooltip: "Todo list",
                  ),
                  //alignment: Alignment.centerRight,
                ),
                flex: 1,
              ),
            ],
          ),
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
      style: GoogleFonts.gloriaHallelujah(
        fontSize: 18,
        //color: Colors.white,
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
          style: GoogleFonts.gloriaHallelujah(
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
