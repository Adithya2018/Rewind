import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/todo_list/view_task.dart';
import 'common.dart';
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

class _ToDoListState extends State<ToDoList> {
  List<Task> listOfTasks = [];
  List<Container> listOfTiles = [];
  bool ascendingOrder = true;
  int sortOption = 0;

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
    Container listItem = Container(
      //width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 0.0),
      padding: EdgeInsets.fromLTRB(15.0, 10.0, 25.0, 5.0),
      decoration: BoxDecoration(
        color: Color(0xFFE6E7E7),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
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
                        child: Checkbox(
                          value: listOfTasks[index].completionStatus,
                          onChanged: (value) {
                            setState(() {
                              listOfTasks[index].completionStatus =
                                  !listOfTasks[index].completionStatus;
                            });
                            print(listOfTasks[index].label);
                            print(listOfTasks[index].completionStatus);
                          },
                        ),
                      ),
                      Text(
                        "${listOfTasks[index].deadline.day} ${_dtf.month[listOfTasks[index].deadline.month - 1]}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gloriaHallelujah(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "${_dtf.formatTime(
                          TimeOfDay(
                              hour: listOfTasks[index].deadline.hour,
                              minute: listOfTasks[index].deadline.minute),
                        )}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gloriaHallelujah(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      listOfTasks[index].deadline.year == DateTime.now().year
                          ? SizedBox(
                              height: 0.0,
                            )
                          : Text(
                              "${listOfTasks[index].deadline.year /*_dtf.formatTime(
                                TimeOfDay(
                                    hour: listOfTasks[index].deadline.hour,
                                    minute: listOfTasks[index].deadline.minute),
                              )*/
                              }",
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
                        //changeDescriptionVisibility(index);
                        /**/ Task temp = await Navigator.push(
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
                      },
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
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Lv",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 12,
                        color: Colors.black,
                      ),
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
    return listItem;
  }

  void updateTodoList() {
    setState(() {
      listOfTiles = List.generate(
        listOfTasks.length,
        (index) => toDoListTile(index: listOfTasks[index].id),
      );
    });
  }

  DateAndTimeFormat _dtf = new DateAndTimeFormat();

  @override
  Widget build(BuildContext context) {
    List<Function> sortFunction = [
      (Task a, Task b) =>
          (ascendingOrder ? 1 : -1) * a.created.compareTo(b.created),
      (Task a, Task b) =>
          (ascendingOrder ? 1 : -1) * a.deadline.compareTo(b.deadline),
      (Task a, Task b) =>
          (ascendingOrder ? 1 : -1) * a.level.compareTo(b.level),
    ];
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
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
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
                          listOfTasks.sort(sortFunction[sortOption]);
                          int id = 0;
                          listOfTasks.forEach((element) {
                            print(element.label);
                            element.id = id++;
                          });
                          updateTodoList();
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
                          int temp = sortOption;
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
                                  sortOption = temp;
                                  listOfTasks.sort(sortFunction[sortOption]);
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
                    tooltip: "Sort",
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
                      listOfTasks.sort(sortFunction[sortOption]);
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
      ),
    );
  }
}
