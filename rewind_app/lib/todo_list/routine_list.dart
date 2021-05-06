import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/models/regular_tasks.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';
import 'package:rewind_app/todo_list/todo_list_state/todo_list_state.dart';

class RegularTasksList extends StatefulWidget {
  @override
  _RegularTasksListState createState() => _RegularTasksListState();
}

class _RegularTasksListState extends State<RegularTasksList>
    with AutomaticKeepAliveClientMixin<RegularTasksList> {
  List<Container> listTiles = [];
  bool ascendingOrder = true;
  int sortByOption = 0;
  List<Function> sortByFunction = [
    //(RegularTask a, RegularTask b) => a.deadline.compareTo(b.deadline),
    (RegularTask a, RegularTask b) => a.level.compareTo(b.level),
  ];

  DateAndTimeFormat dtf = new DateAndTimeFormat();
  TaskLevel taskLevel = TaskLevel();

  bool isSameDate(DateTime d1, DateTime d2) =>
      d2.day == d1.day && d2.month == d1.month && d2.year == d1.year;

  String dateToString(DateTime date) {
    DateTime now = DateTime.now();
    String result = "${date.day} ${dtf.month[date.month - 1]}";
    bool dateToday = isSameDate(now, date);
    result = dateToday ? "Today" : result;
    bool dateTomorrow = isSameDate(
      now.add(
        Duration(days: 1),
      ),
      date,
    );
    result = dateTomorrow ? "Tomorrow" : result;
    print("${now.year}");
    result += (date.year == now.year) ? "" : ", ${date.year}";
    return result;
  }

  Container listTile({
    int index,
  }) {
    final provider = TodoListCommon.of(context);
    final list = provider.rldState.regularTasks;

    Container mainContainer = Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
      decoration: BoxDecoration(
        color: Color(0xFFE6E7E7),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0.0),
          bottom: Radius.circular(0.0),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                constraints: BoxConstraints(
                  maxWidth: 60.0,
                  maxHeight: 60.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Checkbox(
                      value: list[index].completionStatus,
                      onChanged: (value) {
                        provider.switchRegularTaskCompletionStatus(index);
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () async {},
                      onLongPress: () {},
                      child: Text(
                        list[index].label,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.gloriaHallelujah(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(7.5, 0.0, 7.5, 5.0),
                margin: EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5.0),
                    bottom: Radius.circular(5.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Level",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      taskLevel.diffLevelNumeric[list[index].level - 1],
                      size: 40,
                      color: taskLevel
                          .diffLevelNumericColor[list[index].level - 1],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );

    Container weeklyRepeat = Container(
      padding: EdgeInsets.symmetric(vertical: 12.5),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          7,
          (i) => Icon(
            dtf.weekDayIcon[i],
            color: (list[index].weeklyRepeat[i].time.isNotEmpty)
                ? Colors.blue
                : Colors.grey[300],
          ),
        ),
      ),
    );
    int rptEvery = list[index].customRepeat['rptEvery'];
    int nRpt = list[index].customRepeat['nRpt'];
    Container customRepeat = Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MaterialCommunityIcons.repeat,
                ),
                Text(
                  " $rptEvery day${rptEvery == 1 ? "" : "s"}",
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MaterialCommunityIcons.bell_ring,
                ),
                Text(
                  " ${nRpt == -1 ? "Regular" : "$nRpt times"}",
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
    List<IconData> numberIcons = [
      MaterialCommunityIcons.numeric_1_box,
      MaterialCommunityIcons.numeric_2_box,
      MaterialCommunityIcons.numeric_3_box,
      MaterialCommunityIcons.numeric_4_box,
      MaterialCommunityIcons.numeric_5_box,
      MaterialCommunityIcons.numeric_6_box,
      MaterialCommunityIcons.numeric_7_box,
      MaterialCommunityIcons.numeric_8_box,
      MaterialCommunityIcons.numeric_9_box,
    ];

    List<Icon> hourList = [];
    /*if(list[index].weekly){
      if (nextRpt!=null&&nextRpt.hour < 10) {
        hourList.add(
          Icon(
            numberIcons[0],
          ),
        );
        hourList.add(
          Icon(
            numberIcons[nextRpt.hour],
          ),
        );
      }else{
        hourList.add(
          Icon(
            numberIcons[nextRpt.hour~/10],
          ),
        );
        hourList.add(
          Icon(
            numberIcons[nextRpt.hour%10],
          ),
        );
      }
    }*/
    DateTime now = DateTime.now();
    DateTime nextRpt;
    if (list[index].weekly) {
      bool thisWeekDay = false;
      bool nextWeekDay = false;
      list[index].weeklyRepeat.forEach((e1) {
        e1.time.forEach((element) {
          DateTime test = DateTime(
            now.year,
            now.month,
            now.day,
            element.hour,
            element.minute,
          );
          if (test.difference(now).inMilliseconds < 0 && !nextWeekDay) {
            nextRpt = test.add(Duration(days: e1.weekDay - test.weekday + 7));
            nextWeekDay = true;
          }
          //print(test.difference(now).inHours);
          test = test.add(Duration(days: e1.weekDay - test.weekday));
          if (test.difference(now).inMilliseconds > 0 && !thisWeekDay) {
            thisWeekDay = true;
            nextRpt = test;
          }
        });
      });
    } else {
      nextRpt = list[index].customRepeat['startDate'];
    }
    if (nextRpt == null) {
      print("nextRpt is not set");
    } else {
      print("nextRpt is set $nextRpt");
    }
    String dateAndTime = "";
    if (nextRpt == null) {
      String nextRptTime;
      nextRptTime = list[index].weekly ? "<not available>" : "";
      dateAndTime += nextRptTime;
    } else {
      String nextRptTime;
      nextRptTime = list[index].weekly
          ? "${dtf.formatTime(
              TimeOfDay(
                hour: nextRpt.hour,
                minute: nextRpt.minute,
              ),
            )} "
          : "";
      dateAndTime += nextRptTime;
      dateAndTime += dtf.formatDate(
        nextRpt,
        abbr: true,
      );
    }

    Container dateAndTimeContainer = Container(
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
            "$dateAndTime",
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
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
          dateAndTimeContainer,
          list[index].weekly ? weeklyRepeat : customRepeat,
          mainContainer,
        ],
      ),
    );
    return framedContainer;
  }

  int count = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  void updateListTiles() {
    final provider = TodoListCommon.of(context);
    listTiles = List.generate(
      provider.rldState.regularTasks.length,
      (index) => listTile(
        index: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateListTiles();
    final provider = TodoListCommon.of(context);
    final list = provider.rldState.regularTasks;
    return Scrollbar(
      child: ListView(
        shrinkWrap: true,
        children: [
          Text("${list.length}"),
          Column(
            children: listTiles,
          ),
          SizedBox(
            height: 20.0,
          ),
          /*Text("numbers = ${provider.gldState.numbers.length}"),
          Text("list length = ${list.length}"),
          IconButton(
            onPressed: () {
              provider.addToList();
              setState(() {
                ++count;
              });
            },
            icon: Icon(
              FontAwesome5Solid.dragon,
            ),
          ),*/
        ],
      ),
    );
  }
}
