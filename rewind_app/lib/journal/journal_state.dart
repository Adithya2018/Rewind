import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rewind_app/journal/journal_data.dart';
import 'package:rewind_app/models/journal_page.dart';
import 'package:rewind_app/models/user.dart';

class JournalWrapper extends StatefulWidget {
  final Widget child;
  final String boxNameSuffix;
  const JournalWrapper({
    Key key,
    @required this.child,
    @required this.boxNameSuffix,
  }) : super(key: key);
  @override
  _JournalWrapperState createState() => _JournalWrapperState();
}

class _JournalWrapperState extends State<JournalWrapper> {
  JournalData jnlState;
  String journalBoxName = 'journal';

  String dateTimeToKey(DateTime date) {
    String result = "";
    result += date.year.toString();
    result += date.month.toString();
    result += date.day.toString();
    result += date.hour.toString();
    result += date.second.toString();
    result += date.millisecond.toString();
    return result;
  }

  void setBoxName() {
    String boxNameSuffix = Provider.of<UserData>(context).uid;
    journalBoxName = boxNameSuffix + journalBoxName;
  }

  @override
  void initState() {
    super.initState();
    /*for (int i = 0; i < 5; ++i) {
      DateTime now = DateTime.now();
      print(now.toString().length);
    }*/
    /*GoalListData({
    List<Task> tasks,
    Set<int> selected,
    int sortByOption,
    bool ascendingOrder,
  })*/
    print("todo list state initState()");
    journalBoxName = widget.boxNameSuffix + journalBoxName;
    print(journalBoxName);
    jnlState = JournalData(
      pages: List<JournalPage>.from(Hive.box(journalBoxName).values),
      selected: {},
      sortByOption: 0,
      ascendingOrder: true,
    );
    jnlState.pages.forEach((element) {
      print("regular task: ${element.toString()}");
    });
    /*print("goals=${gldState.tasks.length}");
    gldState.tasks.forEach((element) {
      print("goal: ${element.toString()}");
    });*/
    /*rldState = RoutineListData(
      regularTasks: List<RegularTask>.from(Hive.box(ROUTINE_BOX_NAME).values),
      ascendingOrder: true,
    );*/
    /*print("regular tasks=${rldState.regularTasks.length}");
    */
  }

  @override
  void dispose() {
    //Created: 2021-05-07 05:04:04.204453
    jnlState.pages.forEach((task) {
      saveToBox(task.created, task, journalBoxName);
    });
    super.dispose();
  }

  void saveToBox(DateTime created, Object value, String boxName) {
    String key = dateTimeToKey(created);
    Hive.box(boxName).put(
      key,
      value,
    );
  }

  void addPage(JournalPage journalPage) {
    List<JournalPage> newList = [journalPage] + jnlState.pages;
    /*int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });*/
    setState(() => jnlState = jnlState.copy(pages: newList));
  }

  /*void sortPages() {
    List<Task> tasks = List<Task>.from(gldState.tasks);
    tasks.sort(gldState.currentSortByFunction);
    int id = 0;
    tasks.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState.copy(tasks: tasks));
  }*/

  /*void addTask(Task task) {
    List<Task> newList = [task] + gldState.tasks;
    //newList.sort(gldState.currentSortByFunction);
    int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState.copy(tasks: newList));
  }*/

  /*void removeRegularTask(RegularTask regularTask) {
    List<RegularTask> newList = rldState.regularTasks;
    setState(() => rldState = rldState.copy(regularTasks: newList));
  }*/

  void switchListOrder() {
    jnlState.ascendingOrder = !jnlState.ascendingOrder;
  }

  @override
  Widget build(BuildContext context) => JournalCommon(
        child: widget.child,
        jnlState: jnlState,
        stateWidget: this,
      );
}

class JournalCommon extends InheritedWidget {
  final JournalData jnlState;
  final _JournalWrapperState stateWidget;

  const JournalCommon({
    Key key,
    @required Widget child,
    @required this.jnlState,
    @required this.stateWidget,
  }) : super(child: child);

  static _JournalWrapperState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<JournalCommon>().stateWidget;

  @override
  bool updateShouldNotify(JournalCommon oldWidget) {
    return oldWidget.jnlState != jnlState;
  }
}
