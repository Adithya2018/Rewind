import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/todolist/todolist.dart';

class EditTask extends StatefulWidget {
  //final List<Function> taskFunctions;
  final Task task;
  EditTask({
    this.task,
  });
  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  List<String> month = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  List<String> weekDay = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  //var daySuffix = ["st", "nd", "rd", "th",];
  String currentDateAndTime() {
    DateTime now = new DateTime.now();
    return "${weekDay[now.weekday - 1]}, ${now.day} ${month[now.month - 1]} ${now.year}";
  }

  String formatDate(DateTime dateTime) {
    String result =
        "${weekDay[dateTime.weekday - 1]}, ${dateTime.day} ${month[dateTime.month - 1]}";
    String year =
        DateTime.now().year == dateTime.year ? "" : " ${dateTime.year}";
    return "$result$year";
  }

  String formatTime(TimeOfDay timeOfDay) {
    String minute = timeOfDay.minute < 10 ? "0" : "";
    minute += "${timeOfDay.minute}";
    bool beforeMidday = timeOfDay.hour < 12;
    int hour = timeOfDay.hour;
    if (!beforeMidday) {
      hour -= 12;
    }
    hour = hour == 0 ? 12 : hour;
    return "$hour:$minute ${beforeMidday ? "AM" : "PM"}";
  }

  DateTime _deadlineDate;
  Future<void> _selectDeadline(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != _deadlineDate) {
      setState(() {
        _deadlineDate = pickedDate;
      });
    }
  }

  TimeOfDay _deadlineTime;
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: DateTime.now().hour,
        minute: DateTime.now().minute,
      ),
    );
    if (picked != null) {
      setState(() {
        _deadlineTime = picked;
      });
    }
  }

  FocusNode titleFocusNode;
  FocusNode descriptionFocusNode;
  TextEditingController _titleCtrl;
  TextEditingController _descriptionCtrl;

  @override
  void initState() {
    super.initState();
    titleFocusNode = new FocusNode();
    descriptionFocusNode = new FocusNode();
    _titleCtrl = new TextEditingController(
      text: "${widget.task.label}",
    );
    _descriptionCtrl = new TextEditingController(
      text: "${widget.task.description}",
    );
    //_deadlineDate = DateTime.now();
    taskCurrent = Task.fromTask(widget.task);
    _deadlineDate = widget.task.deadline;
    //task = Task.fromTask(widget.task);
    /**/_deadlineTime = TimeOfDay(
      hour: _deadlineDate.hour,
      minute: _deadlineDate.minute,
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
  }

  List<IconData> diffLevelIcon = [
    MaterialCommunityIcons.tea,
    MaterialCommunityIcons.cake_variant,
    MaterialCommunityIcons.alarm_light,
    MaterialCommunityIcons.bomb,
    MaterialCommunityIcons.skull,
  ];

  List<IconData> diffLevelNumeric = [
    MaterialCommunityIcons.numeric_1_box,
    MaterialCommunityIcons.numeric_2_box,
    MaterialCommunityIcons.numeric_3_box,
    MaterialCommunityIcons.numeric_4_box,
    MaterialCommunityIcons.numeric_5_box,
  ];

  List<String> diffLevelText = [
    "My cup of tea",
    "A piece of cake",
    "Are you sure?",
    "Good luck!",
    "Good luck++",
  ];
  //Task task;
  Task taskCurrent;
  String retValue = "";
  @override
  Widget build(BuildContext context) {
    void saveChanges() {
      Navigator.pop(context, taskCurrent);
    }

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
                "Edit task",
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
                  controller: _titleCtrl,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  onChanged: (val) {
                    print("osnvo");
                    setState(() {
                      retValue = val;
                    });
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
                child: TextFormField(
                  focusNode: descriptionFocusNode,
                  controller: _descriptionCtrl,
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
              TextButton(
                onPressed: () {
                  _selectDeadline(context);
                },
                child: Text(
                  "Deadline:",
                  style: GoogleFonts.gloriaHallelujah(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "Date: ${_deadlineDate == null ? "???" : formatDate(_deadlineDate)}",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      _selectDeadline(context);
                      titleFocusNode.unfocus();
                      descriptionFocusNode.unfocus();
                    },
                    icon: Icon(
                      MaterialCommunityIcons.calendar,
                    ),
                    tooltip: "Select date",
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "Time: ${_deadlineTime == null ? "???" : formatTime(_deadlineTime)}",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      _selectTime(context);
                    },
                    icon: Icon(
                      MaterialCommunityIcons.clock_outline,
                    ),
                    tooltip: "Select time",
                  ),
                ],
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
                    diffLevelNumeric[taskCurrent.level - 1],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Icon(
                diffLevelIcon[taskCurrent.level - 1],
                size: 80.0,
              ),
              Text(
                diffLevelText[taskCurrent.level - 1],
                style: GoogleFonts.gloriaHallelujah(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
                child: Slider(
                  activeColor: Color(0xFFB2E5E3),
                  inactiveColor: Colors.white,
                  value: taskCurrent.level.toDouble(),
                  onChanged: (val) {
                    /**/ titleFocusNode.unfocus();
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
                      "Save",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      print("Save");
                      print(currentDateAndTime());
                      taskCurrent = Task.fromTask(taskCurrent);
                      print("${taskCurrent.label}");
                      setState(() {
                        taskCurrent.label = _titleCtrl.text;
                        taskCurrent.description = _descriptionCtrl.text;
                        taskCurrent.level = taskCurrent.level;
                        //taskCurrent.deadline = _deadlineDate;
                        //taskCurrent.deadlineTime = _deadlineTime;
                        if (_deadlineDate != null && _deadlineTime != null) {
                          taskCurrent.deadline = DateTime(
                            _deadlineDate.year,
                            _deadlineDate.month,
                            _deadlineDate.day,
                            _deadlineTime.hour,
                            _deadlineTime.minute,
                          );
                        } else {
                          print("time or date is null");
                        }
                      });
                      saveChanges();
                    },
                  ),
                ),
              ),
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
                      "Cancel",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      print("Cancel");
                      print(currentDateAndTime());
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
/*
print("Save");
                      //Navigator.of(context).pushNamed('/ach');
                      task = Task.fromTask(taskCurrent);
                      print("${task.label}");
                      setState(() {
                        task.label = retValue;
                      });
                      saveChanges();
 */
