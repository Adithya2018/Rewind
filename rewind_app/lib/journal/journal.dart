import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/models/journal_page/journal_page.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';
import 'package:rewind_app/todo_list/todo_list_state/todo_list_state.dart';
import 'edit_journal_page.dart';
import 'journal_state.dart';

class Journal extends StatefulWidget {
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> with SingleTickerProviderStateMixin {
  List<Container> listTiles = [];
  List<Container> test = [];
  bool? ascendingOrder = true;
  int? sortByOption = 0;
  TaskLevel taskLevel = TaskLevel();

  bool showActive = true;

  bool isSameDate(DateTime d1, DateTime d2) =>
      d2.day == d1.day && d2.month == d1.month && d2.year == d1.year;

  String dateToString(DateTime date) {
    DateTime now = DateTime.now();
    String result = "${date.day} ${dtf.month[date.month - 1]}";
    bool dateToday = isSameDate(now, date);
    result = dateToday ? "Today" : result;
    bool dateTomorrow = isSameDate(
        now.add(Duration(
          days: 1,
        )),
        date);
    result = dateTomorrow ? "Tomorrow" : result;
    print("${now.year}");
    result += (date.year == now.year) ? "" : ", ${date.year}";
    return result;
  }

  Container listTile({
    required int index,
  }) {
    final list = JournalCommon.of(context).jnlState!.pages!;
    DateTime created = list[index]!.created!;
    TimeOfDay timeOfDay = TimeOfDay(
      hour: created.hour,
      minute: created.minute,
    );
    Container timeContainer = Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${dtf.formatTime(timeOfDay)}",
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
    Container titleArea = Container(
      padding: EdgeInsets.only(left: 10.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Text(
        list[index]!.title!,
        style: GoogleFonts.gloriaHallelujah(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
    Container contentArea = Container(
      padding: EdgeInsets.only(
        left: 10.0,
        bottom: 10.0,
      ),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Text(
        list[index]!.content!.isEmpty ? "<no content>" : list[index]!.content!,
        style: GoogleFonts.gloriaHallelujah(
          fontSize: 12,
          color: Colors.black,
        ),
        maxLines: 3,
      ),
    );

    Container framedContainer = Container(
      margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 0.0),
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
          bottom: Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 3.0,
            spreadRadius: 1.0,
            offset: Offset(1.0, 2.0),
          ),
        ],
      ),
      child: Column(
        children: [
          timeContainer,
          GestureDetector(
            onTap: () async {
              print("edit journal${dtf.formatTime(timeOfDay)}");
              JournalPage? temp = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditJournalPage(
                    journalPage: list[index],
                    editMode: true,
                  ),
                ),
              );
              if (temp != null) {
                setState(() {
                  list[index] = JournalPage.fromJournalPage(temp);
                });
              } else {
                print("edit journal page cancelled");
              }
            },
            child: Column(
              children: [
                titleArea,
                contentArea,
              ],
            ),
          ),
        ],
      ),
    );
    return framedContainer;
  }

  void updateGoals() {
    final list = JournalCommon.of(context).jnlState!.pages!;
    listTiles = List.generate(
      list.length,
      (index) => listTile(
        index: index,
      ),
    )..add(
        Container(
          height: 12.0,
        ),
      );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    //Hive.deleteFromDisk();
  }

  DateAndTimeFormat dtf = new DateAndTimeFormat();
  @override
  Widget build(BuildContext context) {
    updateGoals();
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
                Icons.more_vert_sharp,
                color: Colors.black,
                size: 30.0,
              ),
              tooltip: 'Refresh',
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Scrollbar(
        child: ListView(
          children: listTiles,
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
              color: Colors.blue[200]!,
              offset: Offset(0.0, -0.5),
              blurRadius: 5.0,
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
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () async {
                      print("Add page");
                      JournalPage? temp = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditJournalPage(
                            journalPage: new JournalPage(),
                            editMode: false,
                          ),
                        ),
                      );
                      if (temp != null) {
                        JournalCommon.of(context).addPage(temp);
                        print("Regular task created");
                      } else {
                        print("No regular task created");
                      }
                    },
                    onLongPress: () {},
                    child: Icon(
                      Icons.add_circle, // MaterialCommunityIcons.plus_circle,
                      color: Colors.lightBlueAccent,
                      size: 55,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () async {
                      await showDialog<int>(
                        context: context,
                        builder: (BuildContext context) {
                          int? temp = sortByOption;
                          return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Sort by"),
                                Spacer(),
                                Icon(
                                  Icons.add_circle, // MaterialCommunityIcons.sort,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            content: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Scrollbar(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                          title: const Text('Date created'),
                                          leading: Radio<int>(
                                            value: 0,
                                            groupValue: temp,
                                            onChanged: (value) {
                                              setState(() {
                                                temp = value;
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text('Deadline'),
                                          leading: Radio<int>(
                                            value: 1,
                                            groupValue: temp,
                                            onChanged: (value) {
                                              setState(() {
                                                temp = value;
                                              });
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text('Level'),
                                          leading: Radio<int>(
                                            value: 2,
                                            groupValue: temp,
                                            onChanged: (value) {
                                              setState(() {
                                                temp = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  sortByOption = temp;
                                  Navigator.of(context).pop();
                                },
                                child: Text("Apply"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Cancel"),
                              ),
                            ],
                          );
                        },
                      );
                      TodoListCommon.of(context).sortTasksBy(sortByOption);
                      updateGoals();
                      print("sorted");
                    },
                    icon: Icon(
                      Icons.add_circle, // MaterialCommunityIcons.sort,
                      color: Colors.black,
                      size: 30,
                    ),
                    tooltip: "Sort by",
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      ascendingOrder!
                          ? Icons.add_circle // MaterialCommunityIcons.alpha_a_circle
                          : Icons.add_circle, // MaterialCommunityIcons.alpha_d_circle,
                      color: Colors.blue[800],
                      size: 35,
                    ),
                    onPressed: () {
                      print("sort in ascending or descending");
                      JournalCommon.of(context).switchListOrder();
                      print(
                          "Order: ${JournalCommon.of(context).jnlState!.ascendingOrder! ? "asc" : "desc"}ending");
                      //JournalCommon.of(context).sortTasks();
                      setState(() {
                        ascendingOrder =
                            JournalCommon.of(context).jnlState!.ascendingOrder;
                      });
                      updateGoals();
                    },
                    tooltip: "Order: ${ascendingOrder! ? "asc" : "desc"}ending",
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
