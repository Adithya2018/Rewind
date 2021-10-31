import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/models/regular_task.dart';
import 'package:rewind_app/models/task.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';
import './todo_list_state/todo_list_state.dart';
import 'edit_task.dart';

class GoalList extends StatefulWidget {
  @override
  _GoalListState createState() => _GoalListState();
}

class _GoalListState extends State<GoalList>
    with AutomaticKeepAliveClientMixin<GoalList> {
  List<Container> listTiles = [];
  bool ascendingOrder = true;
  int sortByOption = 0;
  List<Function> sortByFunction = [
    //(RegularTask a, RegularTask b) => a.deadline.compareTo(b.deadline),
    (RegularTask a, RegularTask b) => a.level!.compareTo(b.level!),
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

  Container goalsListTile({
    required int index,
  }) {
    /*Container taskDescription = Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0.0),
          //bottom: Radius.zero,
        ),
      ),
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: Color(0xFFF3EFE4),
            ),
            child: Scrollbar(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                maxLines: 15,
                minLines: 3,
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Gloria',
                  fontSize: 14,
                  color: Color(0xFF0938BC),
                ),
                decoration: InputDecoration(
                  hintText: "Write something",
                  contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );*/
    final list = TodoListCommon.of(context).gldState!.tasks!;
    final created = list[index].created!;
    final deadline = list[index].deadline!;
    String createdTime = dtf.formatTime(
      TimeOfDay(
        hour: created.hour,
        minute: created.minute,
      ),
    );
    print("${dtf.formatDate(created)}");
    String deadlineTime = dtf.formatTime(
      TimeOfDay(
        hour: deadline.hour,
        minute: deadline.minute,
      ),
    );
    String createdDate = dateToString(created);
    String deadlineDate = dateToString(deadline);
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
                        setState(() {
                          //final provider = TodoListCommon.of(context);
                          list[index].completionStatus =
                          !list[index].completionStatus!;
                        });
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
                      onPressed: () async {
                        Task? temp = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTask(
                              taskCurrent: list[index],
                              editMode: true,
                            ),
                          ),
                        );
                        if (temp != null) {
                          setState(() {
                            list[index] = new Task.fromTask(temp);
                          });
                        }
                        /*TodoListCommon.of(context).sortTasks(
                          currentSortByFunction(),
                        );*/
                        updateListTiles();
                      },
                      onLongPress: () {},
                      child: Text(
                        list[index].label!,
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
                      taskLevel.diffLevelNumeric[list[index].level! - 1],
                      size: 40,
                      color: taskLevel
                          .diffLevelNumericColor[list[index].level! - 1],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
    Container progressBar = Container(
      height: 37.0,
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(9.0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 5.0,
          ),
          Icon(
            Icons.timelapse, //MaterialCommunityIcons.clock_start,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 5.0,
              ),
              //color: Colors.white,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white,
                    Colors.redAccent,
                  ],
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red[600],
                      ),
                    ),
                    flex: DateTime.now().difference(created).inMilliseconds,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                    flex: deadline.difference(DateTime.now()).inMilliseconds,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Icon(
            Icons.timelapse, //MaterialCommunityIcons.flag_checkered,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(
            width: 7.5,
          ),
        ],
      ),
    );

    Container dateContainer = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10.0,
          ),
          Text(
            "$createdTime,\n$createdDate",
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Text(
            "$deadlineTime,\n$deadlineDate",
            style: GoogleFonts.gloriaHallelujah(
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: 10.0,
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
          progressBar,
          mainContainer,
          dateContainer,
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
    final list = TodoListCommon.of(context).gldState!.tasks!;
    listTiles = List.generate(
      list.length,
      (index) => goalsListTile(
        index: index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    updateListTiles();
    return Scrollbar(
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: listTiles,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
