import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rewind_app/todolist/viewtask.dart';

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
  var descriptionVisible = [
    false,
    false,
    false,
  ];

  var completionStatus = [
    false,
    false,
    false,
  ];

  void changeDescriptionVisibility(int i) {
    setState(() {
      descriptionVisible[i] = !descriptionVisible[i];
    });
  }

  void changeCompletionStatus(int i) {
    setState(() {
      completionStatus[i] = !completionStatus[i];
    });
  }
  Task sampleTask = new Task();

  @override
  Widget build(BuildContext context) {
  /*Task sampleTask = new Task();
    sampleTask.id = 1;
    sampleTask.label = "Assignment";
    sampleTask.description = "some description";
    sampleTask.deadline = [];
    sampleTask.created = [];
    sampleTask.level = 1;
    sampleTask.completed = false;*/
    Container createTask({
      String label,
      String description,
      DateTime deadline,
      int level,
      int index,
      //Task task,
    }) {
      Container taskDescription = Container(
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
      );
      Container listItem = Container(
        width: MediaQuery.of(context).size.width,
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
                            value: completionStatus[index],
                            onChanged: (value) {
                              changeCompletionStatus(index);
                            },
                          ),
                        ),
                        Text(
                          "13th APR,\n9:30 pm",
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
                SizedBox(
                  width: 5.0,
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
                          Task temp = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTask(
                                task: sampleTask,
                              ),
                            ),
                          );
                          if (temp != null) {
                            print("knsdv");
                            setState(() {
                              sampleTask = Task.fromTask(temp);
                            });
                          } else {
                            print("cancel or back button");
                          }
                        },
                        child: Text(
                          label,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.gloriaHallelujah(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      /*Text(
                        "13th APR, 9:30 pm",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.gloriaHallelujah(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),*/
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
                        textAlign: TextAlign.left,
                        style: GoogleFonts.gloriaHallelujah(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "$level",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.gloriaHallelujah(
                          fontSize: 25,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: this.descriptionVisible[index] ? 15.0 : 0.0,
            ),
            this.descriptionVisible[index] ? taskDescription : SizedBox(),
            SizedBox(
              height: this.descriptionVisible[index] ? 15.0 : 0.0,
            ),
          ],
        ),
      );
      return listItem;
    }

    return Scaffold(
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
                color: Colors.white,
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
                children: [
                  Container(
                    width: 119.0,
                    margin: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
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
                            builder: (context) => EditTask(
                              task: sampleTask,
                            ),
                          ),
                        );
                        if (temp != null) {
                          print(temp.description);
                          print("saved");
                          print("temp.label is ${temp.label}");
                          setState(() {
                            sampleTask.label = temp.label;
                            print("sampleTask.label is ${sampleTask.label}");
                          });
                        } else {
                          print("not saved");
                        }
                      },
                    ),
                  )
                ],
              ),
              createTask(
                label: "${sampleTask.label}",
                description: "${sampleTask.description}",
                deadline: sampleTask.deadline,
                level: sampleTask.level,
                index: 0,
              ),
              Text(
                "${sampleTask.label}",
                style: GoogleFonts.gloriaHallelujah(),
              ),
              /*createTask(
                label: "Networks assignment",
                description: "",
                deadline: "Today",
                level: 2,
                index: 0,
                task: sampleTask,
              ),*/
              /*createTask(
                label: "Compiler design assignment",
                description: "",
                deadline: "Today",
                level: 2,
                index: 1,
              ),
              createTask(
                label: "Networks viva",
                description: "",
                deadline: "Today",
                level: 3,
                index: 2,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class Task {
  int id;
  String label;
  String description;
  DateTime deadline;
  //TimeOfDay deadlineTime;
  int level;
  DateTime created;
  bool completionStatus;
  DateTime completed;
  Task() {
    id = 1;
    label = "";
    description = "";
    deadline = null;
    //deadlineTime = null;
    created = null;
    level = 1;
    completionStatus = false;
    completed = null;
  }
  Task.fromTask(Task task) {
    this.id = task.id;
    this.label = task.label;
    this.description = task.description;
    this.deadline = task.deadline;
    this.level = task.level;
    this.created = task.created;
    this.completionStatus = task.completionStatus;
    this.completed = task.completed;
  }
}
/*
    Task sampleTask = new Task();
    sampleTask.id = 1;
    sampleTask.label = "Assignment";
    sampleTask.description = "some description";
    sampleTask.deadline = [];
    sampleTask.created = [];
    sampleTask.level = 1;
    sampleTask.completed = false;
 */
