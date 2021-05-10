import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/app_data/app_data_state.dart';
import 'package:rewind_app/journal/edit_journal_page.dart';
import 'package:rewind_app/journal/journal_state.dart';
import 'package:rewind_app/models/journal_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int playerLevel;
  int xp;
  int health;
  int trophies;

  String dateTimeToKey(DateTime date) {
    String result = "";
    result += date.year.toString();
    result += date.month.toString();
    result += date.day.toString();
    result += date.hour.toString();
    result += date.second.toString();
    result += date.millisecond.toString();
    return result;
  }

  void saveToBox(DateTime created, Object value, String boxName) {
    String key = dateTimeToKey(created);
    Hive.box(boxName).put(
      key,
      value,
    );
  }

  List<Widget> getRoutineList() {
    List<Widget> list = List<Widget>.generate(5, (index) {
      return Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New challenge!",
              textAlign: TextAlign.left,
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    });
    return list;
  }

  Column getCurrentJournalEntry() {
    String boxNameSuffix = AppDataCommon.of(context).appData.userdata.uid;
    List<JournalPage> pages =
        List<JournalPage>.from(Hive.box('${boxNameSuffix}journal').values);
    JournalPage temp;
    if (pages.isEmpty) {
      temp = JournalPage();
    } else {
      temp = pages.first;
      pages.forEach((element) {
        if (element.created.millisecondsSinceEpoch <
            temp.created.millisecondsSinceEpoch) {
          temp = element;
        }
      });
    }
    Text title = Text(
      temp.title.isEmpty ? "What happened today?" : temp.title,
      style: GoogleFonts.gloriaHallelujah(
        fontSize: 17,
      ),
    );
    Expanded contentArea = Expanded(
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: 7.5,
          right: 7.5,
        ),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Text(
              temp.content.isEmpty ? "Write something" : temp.content,
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 12,
                color: Color(0xFF0938BC),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ),
    );
    Column result = Column(
      children: [
        title,
        SizedBox(
          height: 5.0,
        ),
        contentArea,
      ],
    );
    return result;
  }

  TabController tabCtrl;
  Container createStatContainer(
    String label, {
    IconData statIconData,
    Color iconColor,
    int statCurrent,
    int statMax,
  }) {
    Container statContainer = new Container(
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[600],
                            ),
                          ),
                          flex: statCurrent,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
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
    Container framedContainer = Container(
      padding: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.black,
            Colors.blueGrey[300],
          ],
        ),
      ),
      child: statContainer,
    );
    return framedContainer;
  }

  double getScWidth() {
    return MediaQuery.of(context).size.width;
  }

  DateTime now;

  @override
  void initState() {
    super.initState();
    //initializeGameInfo();
    tabCtrl = TabController(
      initialIndex: 1,
      vsync: this,
      length: 4,
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    tabCtrl.dispose();
  }

  ScrollController scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    Container health = createStatContainer(
      "Health",
      statIconData: Icons.healing, //Icons.health_and_safety,
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
      // color: Color(0xFF29323B),
      color: Colors.black,
      // color: Colors.blueGrey[900],
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
    Container getJournalingStreakBar({
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

    Widget emptyContainer = Container(
      //margin: EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 0.0),
      constraints: BoxConstraints(
        minHeight: 40.0,
        maxHeight: 200.0,
        //minWidth: MediaQuery.of(context).size.width,
        maxWidth: MediaQuery.of(context).size.width - 80,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
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
    );

    Widget streakGraph = Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      constraints: BoxConstraints(
        minHeight: 40.0,
        maxHeight: 200.0,
        maxWidth: MediaQuery.of(context).size.width,
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
            alignment: Alignment.center,
            height: 45.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
            ),
            child: Text(
              "Streak graph",
              textAlign: TextAlign.center,
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 155.0,
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getJournalingStreakBar(
                    current: 70,
                    day: "M",
                  ),
                  getJournalingStreakBar(
                    current: 64,
                    day: "T",
                    done: true,
                  ),
                  getJournalingStreakBar(
                    current: 80,
                    day: "W",
                    done: false,
                  ),
                  getJournalingStreakBar(
                    current: 70,
                    day: "T",
                  ),
                  getJournalingStreakBar(
                    current: 64,
                    day: "F",
                  ),
                  getJournalingStreakBar(
                    current: 80,
                    day: "S",
                  ),
                  getJournalingStreakBar(
                    current: 90,
                    day: "Today",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    Container notification = Container(
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
            ),
          ),
        ],
      ),
    );

    Container journalOverview = Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      constraints: BoxConstraints(
        minHeight: 100.0,
        maxHeight: 200.0,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
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
            padding: EdgeInsets.only(left: 20.0),
            height: 45.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Journal",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.open_in_new,
                    color: Colors.blue,
                  ),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    print("Journal");
                    Navigator.of(context).pushNamed('/jou');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: 5.0,
                right: 5.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: GestureDetector(
                child: getCurrentJournalEntry(),
                onTap: () async {
                  print("Journal");
                  String boxNameSuffix =
                      AppDataCommon.of(context).appData.userdata.uid;
                  List<JournalPage> pages = List<JournalPage>.from(
                      Hive.box('${boxNameSuffix}journal').values);
                  if (pages.isEmpty) {
                    JournalPage temp = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditJournalPage(
                          journalPage: new JournalPage(),
                          editMode: false,
                        ),
                      ),
                    );
                    if (temp != null) {
                      saveToBox(temp.created, temp, boxNameSuffix + "journal");
                      print("Journal page created");
                    } else {
                      print("No journal page created");
                    }
                  } else {
                    JournalPage firstPage = pages.first;
                    pages.forEach((element) {
                      if (element.created.millisecondsSinceEpoch <
                          firstPage.created.millisecondsSinceEpoch) {
                        firstPage = element;
                      }
                    });
                    firstPage = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditJournalPage(
                          journalPage: firstPage,
                          editMode: false,
                        ),
                      ),
                    );
                    if (firstPage != null) {
                      JournalCommon.of(context).addPage(firstPage);
                      print("Regular task created");
                    } else {
                      print("No regular task created");
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );

    Widget todoOverview = Container(
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      constraints: BoxConstraints(
        minHeight: 100.0,
        maxHeight: 200.0,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
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
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20.0),
            height: 45.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "Todo",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.open_in_new,
                    color: Colors.blue,
                  ),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    print("Open todo");
                    Navigator.of(context).pushNamed('/tdl');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: getRoutineList()
                      ..add(
                        SizedBox(
                          height: 5.0,
                        ),
                      ),
                  ),
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
        preferredSize: Size.fromHeight(190.0),
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(130.0),
            child: gameStatus,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.cloud_off,
                color: Colors.blue,
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
      body: TabBarView(
        controller: tabCtrl,
        children: [
          Column(
            children: [
              Expanded(
                child: streakGraph,
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: streakGraph,
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: journalOverview,
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: todoOverview,
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 0.0),
              constraints: BoxConstraints(
                maxHeight: 190.0,
              ),
              decoration: BoxDecoration(
                //color: Colors.cyan,
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blueGrey[100],
                    Colors.blue[200],
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 10.0,
                      bottom: 5.0,
                    ),
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
                      radius: 40.0,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Text(
                    "${AppDataCommon.of(context).appData.userName.isEmpty ? "<no username>" : AppDataCommon.of(context).appData.userName}",
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "${AppDataCommon.of(context).appData.userdata.email}",
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        decoration: new BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[200],
              // color: Colors.grey,
              offset: Offset(0.0, -0.5),
              blurRadius: 5.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: TabBar(
          controller: tabCtrl,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.stacked_bar_chart, //Icons.query_stats,
                    color: Colors.green,
                    size: 28,
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.blue,
                    size: 40,
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu_book,
                    color: Colors.orange[700],
                    size: 28,
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.list_alt,
                    color: Colors.blue[800],
                    size: 28,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
