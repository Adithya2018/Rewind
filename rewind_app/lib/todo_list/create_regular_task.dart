import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class CreateRegularTask extends StatefulWidget {
  @override
  _CreateRegularTaskState createState() => _CreateRegularTaskState();
}

class _CreateRegularTaskState extends State<CreateRegularTask>
    with TickerProviderStateMixin {
  RegularTask taskCurrent;
  DateAndTimeFormat dtf = DateAndTimeFormat();
  TaskLevel taskLevel = TaskLevel();

  DateTime deadlineDate;
  Future<void> _selectDeadlineDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: now, //(deadlineDate==null)?now:deadlineDate,
      firstDate: DateTime(
        now.year,
        now.month,
        now.day,
      ),
      lastDate: DateTime(now.year + 50),
    );
    if (pickedDate != null && pickedDate != deadlineDate) {
      print(deadlineDate);
      setState(() {
        deadlineDate = pickedDate;
      });
    }
  }

  TimeOfDay deadlineTime;

  Future<Null> _selectDeadlineTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: DateTime.now().hour,
        minute: DateTime.now().minute,
      ),
    );
    if (picked != null) {
      print("pickedTime: $picked");
      setState(() {
        deadlineTime = picked;
      });
    }
  }

  FocusNode titleFocusNode;
  FocusNode descriptionFocusNode;
  TextEditingController titleCtrl;
  TextEditingController descriptionCtrl;
  TabController tabController;
  Animation timeSelectedAnimation;
  AnimationController timeSelectedAnimationCtrl;
  Tween colorTween;
  ScrollController timeListScrollCtrl;

  @override
  void initState() {
    super.initState();
    taskCurrent = new RegularTask();
    titleFocusNode = new FocusNode();
    descriptionFocusNode = new FocusNode();
    titleCtrl = new TextEditingController();
    descriptionCtrl = new TextEditingController();
    tabController = new TabController(
      vsync: this,
      length: 2,
    );
    dayAndTime = new List.generate(7, (index) {
      return DayAndTime(index + 1);
    });
    timeSelectedAnimationCtrl = AnimationController(
      duration: const Duration(
        milliseconds: 600,
      ),
      vsync: this,
    );
    timeSelectedAnimation = ColorTween(
      begin: Colors.lightBlue,
      end: Colors.white,
    ).animate(timeSelectedAnimationCtrl)
      ..addListener(() {
        setState(() {
          if (timeSelectedAnimationCtrl.isCompleted) {
            timeSelectedAnimationCtrl.reset();
          }
        });
      });
    timeListScrollCtrl = ScrollController(
      initialScrollOffset: 0.0,
    );
  }

  List<Widget> createTimeList() {
    int i = -1;
    i = dayAndTime[selectedWeekDay - 1].time.indexWhere((element) {
      return element == deadlineTime;
    });
    List<Widget> list = List.generate(
      dayAndTime[selectedWeekDay - 1].time.length,
      (index) {
        int l = dayAndTime[selectedWeekDay - 1].time.length;
        TimeOfDay t = dayAndTime[selectedWeekDay - 1].time[index];
        print("index = ${index == i} $index ${l - 1}");
        Container result = Container(
          constraints: BoxConstraints(
            maxHeight: 50.0,
          ),
          decoration: BoxDecoration(
            color: (index == i && timeSelectedAnimationCtrl.isAnimating)
                ? timeSelectedAnimation.value
                : Colors.white, //Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.blueGrey,
                width: 1.5,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10.0,
              ),
              Text(
                "${index + 1})",
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 25.0,
              ),
              Text(
                dtf.formatTime(t),
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 16,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    timeSelectedAnimationCtrl.reset();
                    dayAndTime[selectedWeekDay - 1].time.removeAt(index);
                  });
                },
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
        return result;
      },
    );
    return list;
  }

  @override
  void dispose() {
    super.dispose();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    tabController.dispose();
    timeSelectedAnimationCtrl.dispose();
    timeListScrollCtrl.dispose();
  }

  Future<void> showErrorMessage({String msg}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Error "),
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
            ],
          ),
          content: Container(
            child: Text(
              msg,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Continue"),
            ),
          ],
        );
      },
    );
  }

  int selectedWeekDay = 1;
  List<DayAndTime> dayAndTime = [];

  @override
  Widget build(BuildContext context) {
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
                "New regular task",
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
                print("more options");
              },
            ),
          ],
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 20.0),
                child: TextField(
                  focusNode: titleFocusNode,
                  controller: titleCtrl,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    setState(() {});
                  },
                  cursorColor: Color(0xFFB2E5E3),
                  textAlignVertical: TextAlignVertical.bottom,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(
                      20.0,
                      10.0,
                      20.0,
                      10.0,
                    ), //top and bottom were 15.0
                    hintText: "Title",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 20.0),
                child: TextField(
                  focusNode: descriptionFocusNode,
                  controller: descriptionCtrl,
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (val) {
                    setState(() {});
                  },
                  minLines: 4,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  cursorColor: Color(0xFFB2E5E3),
                  textAlignVertical: TextAlignVertical.bottom,
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    hintText: "Description",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: tabController,
                tabs: [
                  new Tab(
                    child: Text(
                      "Week",
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  new Tab(
                    child: Text(
                      "Month",
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: 280.0,
                color: Colors.blueGrey,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            7,
                            (index) => Column(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (selectedWeekDay != index + 1) {
                                      timeSelectedAnimationCtrl.reset();
                                      setState(() {
                                        selectedWeekDay = index + 1;
                                      });
                                    }
                                    print(
                                        "${dtf.weekDay[selectedWeekDay - 1]}");
                                  },
                                  icon: Icon(
                                    dtf.weekDayIcon[index],
                                    color: (selectedWeekDay == (index + 1))
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "${dtf.weekDay[selectedWeekDay - 1]} (${dayAndTime[selectedWeekDay - 1].time.length})",
                          style: GoogleFonts.gloriaHallelujah(
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          height: 150.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.blue,
                            ),
                          ),
                          child: Scrollbar(
                            child: ListView(
                              controller: timeListScrollCtrl,
                              shrinkWrap: true,
                              children: createTimeList(),
                            ),
                          ),
                        ),
                        IconButton(
                          iconSize: 33,
                          onPressed: () async {
                            timeSelectedAnimationCtrl.reset();
                            deadlineTime = null;
                            await _selectDeadlineTime(context);
                            if (deadlineTime != null) {
                              print("selected time = $deadlineTime");
                              setState(() {
                                int i = dayAndTime[selectedWeekDay - 1]
                                    .time
                                    .indexWhere((element) {
                                  return element == deadlineTime;
                                });
                                if (i == -1) {
                                  dayAndTime[selectedWeekDay - 1].time
                                    ..add(deadlineTime)
                                    ..sort((TimeOfDay a, TimeOfDay b) =>
                                        (a.hour != b.hour)
                                            ? (a.hour > b.hour ? 1 : -1)
                                            : (a.minute > b.minute ? 1 : -1));
                                }
                              });
                              int i = dayAndTime[selectedWeekDay - 1]
                                  .time
                                  .indexWhere((element) {
                                return element == deadlineTime;
                              });
                              //deadlineTime = null;
                              timeListScrollCtrl.jumpTo(51.5 * (i - 1));
                              timeSelectedAnimationCtrl
                                  .forward(); //.whenComplete(() => deadlineTime = null);
                              print("animation finished");
                            } else {
                              print("no time selected");
                            }
                          },
                          icon: Icon(
                            Icons.add_circle_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 100.0,
                      child: Text("data"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Difficulty level:",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.gloriaHallelujah(),
                  ),
                  Icon(
                    taskLevel.diffLevelNumeric[taskCurrent.level - 1],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Icon(
                taskLevel.diffLevelIcon[taskCurrent.level - 1],
                size: 80.0,
              ),
              Text(
                taskLevel.diffLevelText[taskCurrent.level - 1],
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
                child: Slider(
                  activeColor: Color(0xFFB2E5E3),
                  inactiveColor: Color(0xFFB2E5E3),
                  value: taskCurrent.level.toDouble(),
                  onChanged: (val) {
                    titleFocusNode.unfocus();
                    descriptionFocusNode.unfocus();
                    setState(() {
                      taskCurrent.level = val.toInt();
                    });
                    print("${taskCurrent.level}");
                  },
                  min: 1,
                  max: 5,
                  divisions: 4,
                ),
              )
            ],
          ),
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
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextButton(
                    child: Text(
                      "Create",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      print("Create");
                      RegularTask temp = RegularTask();
                      if (titleCtrl.text.isEmpty) {
                        await showErrorMessage(
                          msg: "Title cannot be empty",
                        );
                        return;
                      } else {
                        taskCurrent.label = titleCtrl.text;
                      }
                      temp.description = descriptionCtrl.text;
                      temp.completionStatus = false;
                      temp.level = taskCurrent.level;
                      temp.weeklyRepeat = dayAndTime;
                      Navigator.pop(context, temp);
                    },
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
