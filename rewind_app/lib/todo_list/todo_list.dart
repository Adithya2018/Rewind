import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/controllers/todo_list_ctrl.dart';
import '../models/regular_task/regular_task.dart';
import '../models/task/task.dart';
import 'edit_regular_task.dart';
import 'goals_list.dart';
import 'routine_list.dart';
import 'edit_task.dart';
import 'tdl_common.dart';
// import 'todo_list_state/todo_list_state.dart';

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
    print('index $index');
    final list = Get.find<TodoListController>().gldState.tasks!;
    print('list length ${list.length}');
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
                            list[index] = Task.fromTask(temp);
                          });
                        }
                        //TodoListCommon.of(context).sortTasks();
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
            CommunityMaterialIcons.clock_start,
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
            Icons.info, // MaterialCommunityIcons.flag_checkered,
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
    final list = Get.find<TodoListController>()
        .gldState
        .tasks!; //TodoListCommon.of(context).gldState!.tasks!;
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
        final provider = Get.find<TodoListController>();
        switch (tabCtrl!.index) {
          case 0:
            ascendingOrder = provider.rldState.ascendingOrder;
            break;
          case 1:
            sortByOption = provider.gldState.sortByOption;
            ascendingOrder = provider.gldState.ascendingOrder;
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

  DateTimeFormat dtf = DateTimeFormat();

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
          title: Text(
            "Todo",
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
          bottom: TabBar(
            controller: tabCtrl,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info, // MaterialCommunityIcons.alarm_bell,
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
                      Icons.info, // MaterialCommunityIcons.bullseye_arrow,
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
        ],
      ),
      bottomNavigationBar: Container(
        height: 70.0,
        decoration: BoxDecoration(
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
                      print("Add task");
                      switch (tabCtrl!.index) {
                        case 0:
                          {
                            print("Add regular task");
                            RegularTask? temp = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditRegularTask(
                                  taskCurrent: RegularTask(),
                                  editMode: false,
                                ),
                              ),
                            );
                            if (temp != null) {
                              Get.find<TodoListController>().addRegularTask(
                                temp,
                              );
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
                              /*TodoListCommon.of(context)*/
                              Get.find<TodoListController>().addTask(
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
                      Icons.info, // MaterialCommunityIcons.plus_circle,
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
                                        Icons.info,
                                        // MaterialCommunityIcons.sort,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  content: Obx(() {
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
                                  }),
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
                            Get.find<TodoListController>().sortTasksBy(
                              sortByOption,
                            );
                            updateGoals();
                          }
                          break;
                      }
                    },
                    icon: Icon(
                      Icons.info, // MaterialCommunityIcons.sort,
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
                          ? Icons.info // MaterialCommunityIcons.alpha_a_circle
                          : Icons
                              .info, // MaterialCommunityIcons.alpha_d_circle,
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
                            //TodoListCommon.of(context)
                            Get.find<TodoListController>()
                                .switchTaskListOrder();
                            //TodoListCommon.of(context)
                            print(
                                "Order: ${Get.find<TodoListController>().gldState.ascendingOrder! ? "asc" : "desc"}ending");
                            Get.find<TodoListController>().sortTasks();
                            setState(() {
                              ascendingOrder = Get.find<
                                      TodoListController>() //TodoListCommon.of(context)
                                  .gldState
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
