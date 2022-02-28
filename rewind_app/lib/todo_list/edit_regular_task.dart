import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/models/interval/interval.dart';
import 'package:rewind_app/models/regular_task/regular_task.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class EditRegularTask extends StatefulWidget {
  final taskCurrent;
  final bool? editMode;

  EditRegularTask({this.taskCurrent, this.editMode});

  @override
  _EditRegularTaskState createState() => _EditRegularTaskState();
}

class _EditRegularTaskState extends State<EditRegularTask>
    with TickerProviderStateMixin {
  late RegularTask taskCurrent;
  DateTimeFormat dtf = DateTimeFormat();
  TaskLevel taskLevel = TaskLevel();

  DateTime? startDate;

  Future<DateTime?> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(
        now.year,
        now.month,
        now.day,
      ),
      lastDate: DateTime(now.year + 50),
    );
    return pickedDate;
  }

  final selectedTime = Rxn<TimeOfDay>();

  Future<Null> _selectTime(
    BuildContext context, {
    required String helpText,
    TimeOfDay? initialTime,
  }) async {
    initialTime = initialTime ?? TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      helpText: helpText,
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      selectedTime(picked);
    }
  }

  FocusNode? titleFocusNode;
  FocusNode? descriptionFocusNode;
  TextEditingController? titleCtrl;
  TextEditingController? descriptionCtrl;
  TabController? tabController;
  late Animation timeSelectedAnimation;
  late AnimationController timeSelectedAnimationCtrl;
  Tween? colorTween;
  ScrollController? timeListScrollCtrl;

  @override
  void initState() {
    super.initState();
    taskCurrent = RegularTask.fromRegularTask(widget.taskCurrent);
    titleFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    titleCtrl = TextEditingController(
      text: taskCurrent.label,
    );
    descriptionCtrl = TextEditingController(
      text: taskCurrent.description,
    );
    tabController = TabController(
      vsync: this,
      length: 2,
    );
    weeklyRepeat = taskCurrent.weeklyRepeat;
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
    startDate = taskCurrent.customRepeat!['startDate'];
    rptEveryCtrl = TextEditingController(
      text: "${taskCurrent.customRepeat!['rptEvery']}",
    );
    int? nRpt = taskCurrent.customRepeat!['nRpt'];
    nRptCtrl = TextEditingController(
      text: "${widget.editMode! ? (nRpt == -1 ? "" : nRpt) : ""}",
    );
  }

  List<Widget> createTimeList() {
    int i = -1;
    i = weeklyRepeat![selectedWeekDay - 1].indexWhere((element) {
      return TimeInterval.toTimeOfDay(element.endTime!) == selectedTime.value;
    });
    List<Widget> list = List.generate(
      weeklyRepeat![selectedWeekDay - 1].length,
      (index) {
        TimeOfDay t1 = TimeInterval.toTimeOfDay(
            weeklyRepeat![selectedWeekDay - 1][index].startTime!);
        TimeOfDay t2 = TimeInterval.toTimeOfDay(
            weeklyRepeat![selectedWeekDay - 1][index].endTime!);
        Container item = Container(
          constraints: BoxConstraints(
            maxHeight: 50.0,
          ),
          decoration: BoxDecoration(
            color: (index == i && timeSelectedAnimationCtrl.isAnimating)
                ? timeSelectedAnimation.value
                : Colors.white,
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
                "${index + 1}) ",
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Text(
                    dtf.formatTime(t1),
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    " to ",
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                dtf.formatTime(t2),
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 16,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    timeSelectedAnimationCtrl.reset();
                    weeklyRepeat![selectedWeekDay - 1].removeAt(index);
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
        return item;
      },
    );
    return list;
  }

  @override
  void dispose() {
    super.dispose();
    titleFocusNode!.dispose();
    descriptionFocusNode!.dispose();
    titleCtrl!.dispose();
    descriptionCtrl!.dispose();
    tabController!.dispose();
    timeSelectedAnimationCtrl.dispose();
    timeListScrollCtrl!.dispose();
    rptEveryCtrl!.dispose();
    nRptCtrl!.dispose();
  }

  Future<void> showErrorMessage({String? title, String? msg}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info, // MaterialCommunityIcons.alert,
                color: Colors.red,
                size: 35.0,
              ),
              Text(
                title ?? "Try again",
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: Container(
            child: Text(
              msg!,
              style: GoogleFonts.gloriaHallelujah(
                fontSize: 16,
              ),
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
  List<List<TimeInterval>>? weeklyRepeat = [];
  TextEditingController? rptEveryCtrl;
  TextEditingController? nRptCtrl;

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
                "${widget.editMode! ? "Edit" : "New"} task",
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
                  onChanged: (val) {},
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
                  onChanged: (val) {},
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
                  Tab(
                    child: Text(
                      "Week",
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Custom",
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
                height: 290.0,
                color: Colors.amber[200],
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
                                  icon: Icon(
                                    dtf.weekDayIcon[index],
                                    color: (selectedWeekDay == (index + 1))
                                        ? Colors.blue
                                        : Colors.white,
                                  ),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    if (selectedWeekDay != index + 1) {
                                      timeSelectedAnimationCtrl.reset();
                                      setState(() {
                                        selectedWeekDay = index + 1;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "${dtf.weekDay[selectedWeekDay - 1]} (${weeklyRepeat![selectedWeekDay - 1].length})",
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
                        Spacer(),
                        IconButton(
                          iconSize: 35,
                          onPressed: () async {
                            timeSelectedAnimationCtrl.reset();
                            TimeOfDay? start, end;
                            selectedTime.value = null;
                            await _selectTime(
                              context,
                              helpText: "Start time",
                            );
                            start = selectedTime.value;
                            if (start == null) {
                              return;
                            }
                            selectedTime.value = null;
                            await _selectTime(
                              context,
                              helpText: "End time",
                              initialTime: start,
                            );
                            end = selectedTime.value;
                            if (end == null) {
                              return;
                            }
                            String errMsg =
                                "Start time must be less than end time.";
                            if (start.hour > end.hour) {
                              await showErrorMessage(
                                msg: errMsg,
                              );
                              return;
                            } else if (start.hour == end.hour &&
                                start.minute >= end.minute) {
                              await showErrorMessage(
                                msg: errMsg,
                              );
                              return;
                            }
                            bool timeConflictExists = false;
                            weeklyRepeat![selectedWeekDay - 1]
                                .forEach((element) async {
                              timeConflictExists =
                                  element.containsTime(start!) ||
                                      element.containsTime(end!);
                              if (timeConflictExists) {
                                TimeOfDay t1 = TimeInterval.toTimeOfDay(
                                  element.startTime!,
                                );
                                TimeOfDay t2 = TimeInterval.toTimeOfDay(
                                  element.endTime!,
                                );
                                String s1 = "";
                                s1 += dtf.formatTime(start);
                                s1 += " to ";
                                s1 += dtf.formatTime(end!);
                                String s2 = "";
                                s2 += dtf.formatTime(t1);
                                s2 += " to ";
                                s2 += dtf.formatTime(t2);
                                await showErrorMessage(
                                  msg:
                                      "The selected interval ($s1) conflicts with another $s2",
                                );
                                return;
                              }
                            });
                            if (!timeConflictExists) {
                              setState(() {
                                weeklyRepeat![selectedWeekDay - 1]
                                  ..add(TimeInterval.fromTimes(start!, end!))
                                  ..sort((TimeInterval a, TimeInterval b) =>
                                      (a.startTime!['hh'] != b.startTime!['hh'])
                                          ? (a.startTime!['hh']! >
                                                  b.startTime!['hh']!
                                              ? 1
                                              : -1)
                                          : (a.startTime!['mm']! >
                                                  b.startTime!['mm']!
                                              ? 1
                                              : -1));
                                int i = weeklyRepeat![selectedWeekDay - 1]
                                    .indexWhere((element) {
                                  return TimeInterval.toTimeOfDay(
                                          element.startTime!) ==
                                      start;
                                });
                                print("index = $i");
                                timeListScrollCtrl!.jumpTo(51.5 * (i - 1));
                                timeSelectedAnimationCtrl.forward();
                              });
                            }
                          },
                          icon: Icon(
                            Icons.add_circle_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Start date: ${startDate == null ? "???" : dtf.formatDate(startDate!)}",
                                    style: GoogleFonts.gloriaHallelujah(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  flex: 4,
                                ),
                                Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () async {
                                      DateTime? date =
                                          await _selectDate(context);
                                      if (date != null) {
                                        setState(() {
                                          startDate = date;
                                        });
                                      }
                                    },
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: rptEveryCtrl,
                                    textInputAction: TextInputAction.next,
                                    textAlign: TextAlign.center,
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(
                                          rptEveryCtrl!.text.isEmpty
                                              ? r'[1-9]'
                                              : r'[0-9]',
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    style: GoogleFonts.gloriaHallelujah(
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: "Repeat every",
                                    ),
                                  ),
                                  flex: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    "Days",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.gloriaHallelujah(
                                      fontSize: 15,
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: nRptCtrl,
                                    textAlign: TextAlign.center,
                                    keyboardType:
                                        TextInputType.numberWithOptions(),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(
                                          nRptCtrl!.text.isEmpty
                                              ? r'[1-9]'
                                              : r'[0-9]',
                                        ),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    style: GoogleFonts.gloriaHallelujah(
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: "No. of repeats",
                                      hintText: "(regular by default)",
                                    ),
                                  ),
                                  flex: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    "Times",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.gloriaHallelujah(
                                      fontSize: 15,
                                    ),
                                  ),
                                  flex: 1,
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
                    taskLevel.diffLevelNumeric[taskCurrent.level! - 1],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Icon(
                taskLevel.diffLevelIcon[taskCurrent.level! - 1],
                size: 80.0,
              ),
              Text(
                taskLevel.diffLevelText[taskCurrent.level! - 1],
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
                  value: taskCurrent.level!.toDouble(),
                  onChanged: (val) {
                    titleFocusNode!.unfocus();
                    descriptionFocusNode!.unfocus();
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
        decoration: BoxDecoration(
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
                      "${widget.editMode! ? "Save" : "Create"}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      print("Create");
                      RegularTask temp =
                          RegularTask.fromRegularTask(taskCurrent);
                      if (titleCtrl!.text.isEmpty) {
                        await showErrorMessage(
                          msg: "Title cannot be empty",
                        );
                        return;
                      }
                      switch (tabController!.index) {
                        case 0:
                          {
                            temp.weekly = true;
                            temp.customRepeat = RegularTask.newCustomRepeat;
                            temp.weeklyRepeat = weeklyRepeat;
                          }
                          break;
                        case 1:
                          {
                            temp.weekly = false;
                            temp.weeklyRepeat = RegularTask.newWeekRepeat;
                            if (startDate == null) {
                              await showErrorMessage(
                                msg: "Select a start date",
                              );
                              return;
                            }
                            int rptEvery = 1;
                            if (rptEveryCtrl!.text.isNotEmpty) {
                              rptEvery = int.parse(rptEveryCtrl!.text);
                            }
                            int nRpt = -1;
                            if (nRptCtrl!.text.isNotEmpty) {
                              nRpt = int.parse(nRptCtrl!.text);
                            }
                            temp.customRepeat = {
                              "startDate": startDate,
                              "rptEvery": rptEvery,
                              "nRpt": nRpt,
                            };
                          }
                          break;
                      }
                      temp.label = titleCtrl!.text;
                      temp.description = descriptionCtrl!.text;
                      temp.created = temp.createdDateTime;
                      Get.back(
                        result: temp,
                      );
                      //Navigator.pop(context, temp);
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
