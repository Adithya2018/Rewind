//https://blog.codemagic.io/choosing-the-right-database-for-your-flutter-app/
import 'package:flutter/material.dart';
import 'package:rewind_app/models/regular_task/regular_task.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class AppDataWrapper extends StatefulWidget {
  final Widget child;
  const AppDataWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  _AppDataWrapperState createState() => _AppDataWrapperState();
}

class _AppDataWrapperState extends State<AppDataWrapper> {

  @override
  Widget build(BuildContext context) => TodoListCommon(
    child: widget.child,
    /*gldState: gldState,
    rldState: rldState,*/
    stateWidget: this,
  );

  /*void sortTasks(Function f) {
    List<Task> tasks = List<Task>.from(gldState.tasks);
    tasks.sort(f);
    int id = 0;
    tasks.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState.copy(tasks: tasks));
  }*/

  /*void sortRegularTasks(Function f) {
    List<RegularTask> regularTasks =
    List<RegularTask>.from(rldState.regularTasks);
    regularTasks.sort(f);
    int id = 0;
    regularTasks.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => rldState = rldState.copy(regularTasks: regularTasks));
  }*/

  /*void addTask(Task task, Function f) {
    List<Task> newList = gldState.tasks + [task];
    newList.sort(f);
    int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState.copy(tasks: newList));
  }*/

  /*void switchRegularTaskCompletionStatus(int index){
    List<RegularTask> newList = rldState.regularTasks;
    newList[index].completionStatus = !newList[index].completionStatus;
    setState(() => rldState = rldState.copy(regularTasks: newList));
  }*/

  /*void addRegularTask(RegularTask regularTask) {
    List<RegularTask> newList = rldState.regularTasks + [regularTask];
    newList.sort((RegularTask a, RegularTask b) => a.level.compareTo(b.level));
    int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => rldState = rldState.copy(regularTasks: newList));
  }*/

  void updateGoals() {}

  /*void addToList() {
    List<int> newList = gldState.numbers + [gldState.numbers.length];
    final numbers = newList;
    final newState = gldState.copy(numbers: numbers);
    setState(() => gldState = newState);
  }*/

  /*void reverseList() {
    List<int> newList = gldState.numbers;
    final numbers = newList.reversed.toList();
    final newState = gldState.copy(numbers: numbers);
    setState(() => gldState = newState);
  }*/

  /*setTaskList(List<Task> tasks) {
    final newState = gldState.copy(tasks: tasks);
    setState(() => gldState = newState);
  }*/
}

class TodoListCommon extends InheritedWidget {
  /*final RoutineListData rldState;
  final GoalListData gldState;*/
  final _AppDataWrapperState stateWidget;

  const TodoListCommon({
    Key? key,
    required Widget child,
    /*@required this.gldState,
    @required this.rldState,*/
    required this.stateWidget,
  }) : super(child: child);

  static _AppDataWrapperState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TodoListCommon>()!.stateWidget;

  @override
  bool updateShouldNotify(TodoListCommon oldWidget) {
    return true;//oldWidget.gldState != gldState;
  }
}
