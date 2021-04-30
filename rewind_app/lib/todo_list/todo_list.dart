import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/todo_list/create_regular_task.dart';
import 'edit_task.dart';
import 'tdl_common.dart';
import 'create_task.dart';

class TaskStatus extends StatefulWidget {
  @override
  _TaskStatusState createState() => _TaskStatusState();
}

class _TaskStatusState extends State<TaskStatus> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList>
    with SingleTickerProviderStateMixin {
  List<Task> listOfTasks = [];
  List<Container> listOfTiles = [];
  bool ascendingOrder = true;
  int sortByOption = 0;
  List<Function> sortByFunction = [
    (Task a, Task b) => a.created.compareTo(b.created),
    (Task a, Task b) => a.deadline.compareTo(b.deadline),
    (Task a, Task b) => a.level.compareTo(b.level),
  ];

  Function currentSortByFunction() {
    return (Task a, Task b) =>
        ((ascendingOrder ? 1 : -1) * sortByFunction[sortByOption](a, b)) as int;
  }

  bool addItemMode = true;
  bool showActiveTasks = true;

  Container toDoListTile({
    int index,
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
    final created = listOfTasks[index].created;
    final deadline = listOfTasks[index].deadline;
    String createdTime = "${dtf.formatTime(
      TimeOfDay(
        hour: created.hour,
        minute: created.minute,
      ),
    )}";
    String deadlineTime = "${dtf.formatTime(
      TimeOfDay(
        hour: deadline.hour,
        minute: deadline.minute,
      ),
    )}";
    String createdDate = "${created.day} ${dtf.month[created.month - 1]}";
    createdDate +=
        (created.year == DateTime.now().year) ? "" : ", ${created.year}";
    String deadlineDate = "${deadline.day} ${dtf.month[deadline.month - 1]}";
    deadlineDate +=
        (deadline.year == DateTime.now().year) ? "" : ", ${deadline.year}";
    print(
        "${DateTime.now().millisecondsSinceEpoch - created.millisecondsSinceEpoch}");
    print(
        "${deadline.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch}");
    Container listItem = Container(
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 25.0, 5.0),
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
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Checkbox(
                              value: listOfTasks[index].completionStatus,
                              onChanged: (value) {
                                setState(() {
                                  listOfTasks[index].completionStatus =
                                      !listOfTasks[index].completionStatus;
                                });
                                print("Completion status of:");
                                print("${listOfTasks[index].label}");
                                print("${listOfTasks[index].completionStatus}");
                              },
                            );
                          },
                        ),
                      ),
                      /*Text(
                        "${listOfTasks[index].deadline.day} ${dtf.month[listOfTasks[index].deadline.month - 1]}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gloriaHallelujah(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "${dtf.formatTime(
                          TimeOfDay(
                              hour: listOfTasks[index].deadline.hour,
                              minute: listOfTasks[index].deadline.minute),
                        )}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gloriaHallelujah(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),*/
                      listOfTasks[index].deadline.year == DateTime.now().year
                          ? SizedBox(
                              height: 0.0,
                            )
                          : Text(
                              "${listOfTasks[index].deadline.year}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.gloriaHallelujah(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                    ],
                  ),
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
                        Task temp = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTask(
                              task: listOfTasks[index],
                            ),
                          ),
                        );
                        if (temp != null) {
                          setState(() {
                            listOfTasks[index] = new Task.fromTask(temp);
                          });
                        }
                        listOfTasks.sort(currentSortByFunction());
                        int id = 0;
                        listOfTasks.forEach((element) {
                          print(element.label);
                          element.id = id++;
                        });
                        updateTodoList();
                      },
                      onLongPress: () {},
                      child: Text(
                        listOfTasks[index].label,
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
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Lv",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "${listOfTasks[index].level}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 35,
                        color: Colors.green,
                      ),
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
          Icon(
            MaterialCommunityIcons.clock_start,
            color: Colors.white,
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Container(
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
                    flex: DateTime.now().millisecondsSinceEpoch -
                        created.millisecondsSinceEpoch,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        color: Colors.blueGrey[100],
                      ),
                    ),
                    flex: deadline.millisecondsSinceEpoch -
                        DateTime.now().millisecondsSinceEpoch,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Icon(
            MaterialCommunityIcons.clock_end,
            color: Colors.white,
          ),
          SizedBox(
            width: 2.5,
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
          Icon(
            MaterialCommunityIcons.arrow_right,
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
        //color: Colors.red,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
          bottom: Radius.circular(10.0),
        ),
        /*gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blueGrey[300],
            Colors.black,
            Colors.blueGrey[300],
          ],
        ),*/
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
        children: [progressBar, listItem, dateContainer],
      ),
    );
    return framedContainer;
  }

  void updateTodoList() {
    setState(() {
      listOfTiles = List.generate(
        listOfTasks.length,
        (index) => toDoListTile(index: listOfTasks[index].id),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 2,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  DateAndTimeFormat dtf = new DateAndTimeFormat();
  TabController tabController;

  @override
  Widget build(BuildContext context) {
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
                "To-do list",
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
                Navigator.of(context).popUntil((route) => false);
                Navigator.of(context).pushNamed('/');
              },
            ),
          ],
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MaterialCommunityIcons.alarm_bell,
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
                      MaterialCommunityIcons.bullseye_arrow,
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
        controller: tabController,
        children: [
          Container(),
          Scrollbar(
            child: ListView(
              shrinkWrap: true,
              children: listOfTiles,
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        decoration: new BoxDecoration(
          color: addItemMode ? Colors.grey[100] : Colors.red[300],
          // color: Colors.blueGrey[900],
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
        child: Center(
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Container(
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      print("Add task");
                      setState(() {
                        showActiveTasks = !showActiveTasks;
                      });
                    },
                    child: Icon(
                      showActiveTasks
                          ? MaterialCommunityIcons.run
                          : MaterialCommunityIcons.archive,
                      color: showActiveTasks
                          ? Colors.greenAccent[400]
                          : Colors.brown[400],
                      size: 30,
                    ),
                  ),
                ),
                flex: 1,
              ),

              // Spacer(),
              Expanded(
                child: Container(
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () async {
                      print("${addItemMode ? "Add task" : "Delete task"}");
                      print("$addItemMode");
                      switch (tabController.index) {
                        case 0:
                          {
                            print("Add regular task");
                            Task temp = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateRegularTask(),
                              ),
                            );
                          }
                          break;
                        case 1:
                          {
                            print("Add goal");
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
                    onLongPress: () {
                      setState(() {
                        addItemMode = !addItemMode;
                      });
                    },
                    child: Icon(
                      addItemMode
                          ? MaterialCommunityIcons.plus_circle
                          : MaterialCommunityIcons.delete,
                      color: addItemMode ? Colors.lightBlueAccent : Colors.red,
                      size: 55,
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: MaterialButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      switch (tabController.index) {
                        case 0:
                          {
                            print("sort routine");
                          }
                          break;
                        case 1:
                          {
                            print("sort goals");
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
                                        listOfTasks
                                            .sort(currentSortByFunction());
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
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          break;
                      }
                    },
                    child: Icon(
                      MaterialCommunityIcons.sort,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      ascendingOrder
                          ? MaterialCommunityIcons.alpha_a_circle
                          : MaterialCommunityIcons.alpha_d_circle,
                      color: Colors.blue[800],
                      size: 35,
                    ),
                    onPressed: () {
                      print("sort in ascending or descending");
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
                    tooltip:
                        "Order: ${ascendingOrder ? "ascending" : "descending"}",
                  ),
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
