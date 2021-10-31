import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/regular_task.dart';
import '../models/task.dart';
import 'edit_regular_task.dart';
import 'goal_list.dart';
import 'routine_list.dart';
import 'edit_task.dart';
import 'tdl_common.dart';
import 'todo_list_state/todo_list_state.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList>
    with SingleTickerProviderStateMixin {
  List<Container> listTiles = [];
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
                        TodoListCommon.of(context).sortTasks();
                        updateGoals();
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
              )
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
            Icons.timelapse_rounded, // MaterialCommunityIcons.clock_start,
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
            Icons.flag, // MaterialCommunityIcons.flag_checkered,
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

  void updateGoals() {
    final list = TodoListCommon.of(context).gldState!.tasks!;
    listTiles = List.generate(
      list.length,
      (index) => goalsListTile(
        index: list[index].orderIndex!,
      ),
    );
  }

  TabController? tabCtrl;

  @override
  void initState() {
    super.initState();
    tabCtrl = TabController(
      vsync: this,
      length: 2,
    );
    tabCtrl!.addListener(() {
      setState(() {
        final provider = TodoListCommon.of(context);
        switch (tabCtrl!.index) {
          case 0:
            ascendingOrder = provider.rldState!.ascendingOrder;
            break;
          case 1:
            sortByOption = provider.gldState!.sortByOption;
            ascendingOrder = provider.gldState!.ascendingOrder;
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabCtrl!.dispose();
  }

  DateAndTimeFormat dtf = new DateAndTimeFormat();
  @override
  Widget build(BuildContext context) {
    updateGoals();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
          toolbarHeight: 60.0,
          title: Row(
            children: [
              SizedBox(
                width: 7.0,
              ),
              Text(
                "Todo",
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
                color: Colors.black,
                size: 30.0,
              ),
              tooltip: 'Refresh',
              onPressed: () {
                /*Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).pushNamed('/');*/
              },
            ),
          ],
          bottom: TabBar(
            controller: tabCtrl,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm, //MaterialCommunityIcons.alarm_bell,
                      color: Colors.yellow[600],
                      size: 30.0,
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Text(
                      "routine",
                      style: GoogleFonts.gloriaHallelujah(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_circle_up_sharp, //MaterialCommunityIcons.bullseye_arrow,
                      color: Colors.redAccent,
                      size: 30.0,
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Text(
                      "goals",
                      style: GoogleFonts.gloriaHallelujah(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabCtrl,
        children: [
          RoutineList(),
          GoalList(),
          /*Scrollbar(
            child: ListView(
              shrinkWrap: true,
              children: listTiles,
            ),
          ),*/
        ],
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
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        showActive = !showActive;
                      });
                      print("${showActive ? "active" : "regular"} tasks");
                    },
                    icon: Icon(
                      showActive
                          ? Icons.arrow_circle_up_sharp //MaterialCommunityIcons.run
                          : Icons.arrow_circle_up_sharp, //MaterialCommunityIcons.archive,
                      color: showActive
                          ? Colors.greenAccent[400]
                          : Colors.brown[400],
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () async {
                      print("Add task");
                      switch (tabCtrl!.index) {
                        case 0:
                          {
                            print("Add regular task");
                            RegularTask? temp = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditRegularTask(
                                  taskCurrent: new RegularTask(),
                                  editMode: false,
                                ),
                              ),
                            );
                            if (temp != null) {
                              TodoListCommon.of(context).addRegularTask(temp);
                              print("Regular task created");
                            } else {
                              print("No regular task created");
                            }
                          }
                          break;
                        case 1:
                          {
                            print("Add goal");
                            Task? temp = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTask(
                                  taskCurrent: Task(),
                                  editMode: false,
                                ),
                              ),
                            );
                            if (temp != null) {
                              TodoListCommon.of(context).addTask(
                                temp,
                              );
                              updateGoals();
                            } else {
                              print("No goals created");
                            }
                          }
                          break;
                      }
                    },
                    onLongPress: () {},
                    child: Icon(
                      Icons.arrow_circle_up_sharp, //MaterialCommunityIcons.plus_circle,
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
                      switch (tabCtrl!.index) {
                        case 0:
                          {
                            print("sort routine");
                          }
                          break;
                        case 1:
                          {
                            print("sort goals");
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
                                        Icons.arrow_circle_up_sharp, //MaterialCommunityIcons.sort,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  content: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
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
                                                title:
                                                    const Text('Date created'),
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
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                );
                              },
                            );
                            TodoListCommon.of(context)
                                .sortTasksBy(sortByOption);
                            updateGoals();
                            print("sorted");
                          }
                          break;
                      }
                    },
                    icon: Icon(
                      Icons.arrow_circle_up_sharp, //MaterialCommunityIcons.sort,
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
                          ? Icons.arrow_circle_up_sharp //MaterialCommunityIcons.alpha_a_circle
                          : Icons.arrow_circle_up_sharp, //MaterialCommunityIcons.alpha_d_circle,
                      color: Colors.blue[800],
                      size: 35,
                    ),
                    onPressed: () {
                      print("sort in ascending or descending");
                      switch (tabCtrl!.index) {
                        case 0:
                          {
                            /*final provider = TodoListCommon.of(context);
                            provider.addToList();
                            provider.reverseList();*/
                          }
                          break;
                        case 1:
                          {
                            TodoListCommon.of(context).switchTaskListOrder();
                            print(
                                "Order: ${TodoListCommon.of(context).gldState!.ascendingOrder! ? "asc" : "desc"}ending");
                            TodoListCommon.of(context).sortTasks();
                            setState(() {
                              ascendingOrder = TodoListCommon.of(context)
                                  .gldState!
                                  .ascendingOrder;
                            });
                            updateGoals();
                          }
                          break;
                      }
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

/*Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    iconSize: 30.0,
                    splashColor: Colors.transparent,
                    splashRadius: max(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    onPressed: () async {
                      print("Add task");
                      Task temp = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateRegularTask(),
                        ),
                      );
                      if (temp != null) {
                        print(temp.label);
                        print(temp.description);
                        print(temp.deadline.month);
                        print(temp.deadline.toString());
                        print(temp.created.toString());
                        print("new task created");
                        print("temp.label is ${temp.label}");
                        temp.id = listOfTasks.length;
                        setState(() {
                          listOfTasks.add(temp);
                        });
                        listOfTasks.sort(currentSortByFunction());
                        int id = 0;
                        listOfTasks.forEach((element) {
                          print(element.label);
                          element.id = id++;
                        });
                        updateTodoList();
                      }
                    },
                    icon: Icon(
                      ascendingOrder
                          ? MaterialCommunityIcons.alpha_a_circle
                          : MaterialCommunityIcons.alpha_d_circle,
                    ),
                    tooltip:
                        "Order: ${ascendingOrder ? "ascending" : "descending"}",
                  ),
                  Container(
                    width: 120.0,
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 15.0, 0.0),
                    child: ElevatedButton(
                      child: Row(
                        children: [
                          Icon(
                            MaterialCommunityIcons.plus,
                          ),
                          Text(
                            "ADD TASK",
                            style: GoogleFonts.gloriaHallelujah(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        switch (tabController.index) {
                          case 0:
                            {
                              print("routine");
                            }
                            break;
                          case 1:
                            {
                              print("Add task");
                              Task temp = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateTask(
                                    task: new Task(),
                                  ),
                                ),
                              );
                              if (temp != null) {
                                print(temp.label);
                                print(temp.description);
                                print(temp.deadline.month);
                                print(temp.deadline.toString());
                                print(temp.created.toString());
                                print("new task created");
                                print("temp.label is ${temp.label}");
                                temp.id = listOfTasks.length;
                                setState(() {
                                  listOfTasks.add(temp);
                                });
                                listOfTasks.sort(currentSortByFunction());
                                int id = 0;
                                listOfTasks.forEach((element) {
                                  print(element.label);
                                  element.id = id++;
                                });
                                updateTodoList();
                              }
                            }
                            break;
                        }
                      },
                    ),
                  ),
                  IconButton(
                    iconSize: 30.0,
                    splashColor: Colors.transparent,
                    splashRadius: max(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    onPressed: () {
                      // need async?
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          int temp = sortByOption;
                          return AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Sort by"),
                                Spacer(),
                                Icon(
                                  MaterialCommunityIcons.sort,
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
                                  listOfTasks.sort(currentSortByFunction());
                                  int id = 0;
                                  listOfTasks.forEach((element) {
                                    print(element.label);
                                    element.id = id++;
                                  });
                                  updateTodoList();
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
                    },
                    icon: Icon(
                      MaterialCommunityIcons.sort,
                    ),
                    tooltip: "Sort by",
                  ),
                  IconButton(
                    iconSize: 30.0,
                    splashColor: Colors.transparent,
                    splashRadius: max(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    onPressed: () {
                      setState(() {
                        ascendingOrder = !ascendingOrder;
                      });
                      listOfTasks.sort(currentSortByFunction());
                      int id = 0;
                      listOfTasks.forEach((element) {
                        print(element.label);
                        element.id = id++;
                      });
                      updateTodoList();
                    },
                    icon: Icon(
                      ascendingOrder
                          ? MaterialCommunityIcons.alpha_a_circle
                          : MaterialCommunityIcons.alpha_d_circle,
                    ),
                    tooltip:
                        "Order: ${ascendingOrder ? "ascending" : "descending"}",
                  ),
                ],
              ),
              Column(
                children: listOfTiles,
              ),
            ],
          ),
        ),
      ),*/
