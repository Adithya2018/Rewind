import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/models/task/task.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class EditTask extends StatefulWidget {
  final Task? taskCurrent;
  final bool? editMode;
  EditTask({
    this.taskCurrent,
    this.editMode,
  });
  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  Task? taskCurrent;
  DateAndTimeFormat dtf = new DateAndTimeFormat();
  TaskLevel taskLevel = new TaskLevel();
  //DateTime deadlineDate;
  Future<void> selectDeadline(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(
        now.year,
        now.month,
        now.day,
      ),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != taskCurrent!.deadline) {
      setState(() {
        taskCurrent!.deadline = pickedDate;
      });
    }
  }

  TimeOfDay? deadlineTime;
  Future<Null> selectTime(BuildContext context) async {
    TimeOfDay? initialTime = TimeOfDay.now();
    initialTime = deadlineTime == null ? TimeOfDay.now() : deadlineTime!;
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      setState(() {
        deadlineTime = picked;
      });
    }
  }

  FocusNode? titleFocusNode;
  FocusNode? descriptionFocusNode;
  TextEditingController? titleCtrl;
  TextEditingController? descriptionCtrl;

  @override
  void initState() {
    super.initState();
    titleFocusNode = new FocusNode();
    descriptionFocusNode = new FocusNode();
    titleCtrl = new TextEditingController(
      text: "${widget.taskCurrent!.label}",
    );
    descriptionCtrl = new TextEditingController(
      text: "${widget.taskCurrent!.description}",
    );
    taskCurrent = Task.fromTask(widget.taskCurrent!);
    if (widget.taskCurrent!.deadline != null) {
      taskCurrent!.deadline = widget.taskCurrent!.deadline;
      deadlineTime = TimeOfDay(
        hour: taskCurrent!.deadline!.hour,
        minute: taskCurrent!.deadline!.minute,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleFocusNode!.dispose();
    descriptionFocusNode!.dispose();
    titleCtrl!.dispose();
    descriptionCtrl!.dispose();
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
                Icons.timelapse, //MaterialCommunityIcons.alert,
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
                child: TextFormField(
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
              TextButton(
                onPressed: () {
                  selectDeadline(context);
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
                    "Date:",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${taskCurrent!.deadline == null ? "???" : dtf.formatDate(taskCurrent!.deadline!)}",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      selectDeadline(context);
                      titleFocusNode!.unfocus();
                      descriptionFocusNode!.unfocus();
                    },
                    icon: Icon(
                      Icons.timelapse, //MaterialCommunityIcons.calendar,
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
                    "Time:",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "${deadlineTime == null ? "???" : dtf.formatTime(deadlineTime!)}",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      selectTime(context);
                    },
                    icon: Icon(
                      Icons.timelapse, //MaterialCommunityIcons.clock_outline,
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
                    taskLevel.diffLevelNumeric[taskCurrent!.level! - 1],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Icon(
                taskLevel.diffLevelIcon[taskCurrent!.level! - 1],
                size: 80.0,
              ),
              Text(
                taskLevel.diffLevelText[taskCurrent!.level! - 1],
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
                  value: taskCurrent!.level!.toDouble(),
                  onChanged: (val) {
                    titleFocusNode!.unfocus();
                    descriptionFocusNode!.unfocus();
                    setState(() {
                      taskCurrent!.level = val.toInt();
                    });
                    print("${taskCurrent!.level}");
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
                    onPressed: () async {
                      print("Save");
                      if (titleCtrl!.text.isEmpty) {
                        await showErrorMessage(
                          msg: "Title cannot be empty",
                        );
                        return;
                      }
                      print("is deadlineTime null? ${deadlineTime == null}");
                      if (taskCurrent!.deadline != null &&
                          deadlineTime != null) {
                        taskCurrent!.deadline = DateTime(
                          taskCurrent!.deadline!.year,
                          taskCurrent!.deadline!.month,
                          taskCurrent!.deadline!.day,
                          deadlineTime!.hour,
                          deadlineTime!.minute,
                        );
                      } else {
                        await showErrorMessage(
                          msg: "Select a deadline",
                        );
                        return;
                      }
                      taskCurrent!.label = titleCtrl!.text;
                      taskCurrent!.description = descriptionCtrl!.text;
                      taskCurrent!.created = taskCurrent!.createdDateTime;
                      print("Created: ${taskCurrent!.created}");
                      Navigator.pop(context, taskCurrent);
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
                      Navigator.pop(context, null);
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
