import 'package:flutter/material.dart';
import 'package:rewind_app/todo_list/todo_list_data/routine_list_data.dart';
import 'package:rewind_app/todo_list/todo_list_data/todo_list_data.dart';

import '../tdl_common.dart';

class TodoListWrapper extends StatefulWidget {
  final Widget child;
  const TodoListWrapper({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  _TodoListWrapperState createState() => _TodoListWrapperState();
}

class _TodoListWrapperState extends State<TodoListWrapper> {
  GoalListData gldState = GoalListData();
  RoutineListData rldState = RoutineListData();

  @override
  Widget build(BuildContext context) => TodoListCommon(
        child: widget.child,
        gldState: gldState,
        rldState: rldState,
        stateWidget: this,
      );

  void sortTasks(Function f) {
    List<Task> tasks = List<Task>.from(gldState.tasks);
    tasks.sort(f);
    int id = 0;
    tasks.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState.copy(tasks: tasks));
  }

  void sortRegularTasks(Function f) {
    List<RegularTask> regularTasks =
        List<RegularTask>.from(gldState.regularTasks);
    regularTasks.sort(f);
    int id = 0;
    regularTasks.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState.copy(regularTasks: regularTasks));
  }

  void addTask(Task task, Function f) {
    List<Task> newList = gldState.tasks + [task];
    newList.sort(f);
    int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState.copy(tasks: newList));
  }

  void addRegularTask(RegularTask regularTask) {
    List<RegularTask> newList = rldState.regularTasks + [regularTask];
    newList.sort((RegularTask a, RegularTask b) => a.level.compareTo(b.level));
    int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => rldState = rldState.copy(regularTasks: newList));
  }

  void updateGoals() {}

  void addToList() {
    List<int> newList = gldState.numbers + [gldState.numbers.length];
    final numbers = newList;
    final newState = gldState.copy(numbers: numbers);
    setState(() => gldState = newState);
  }

  void reverseList() {
    List<int> newList = gldState.numbers;
    final numbers = newList.reversed.toList();
    final newState = gldState.copy(numbers: numbers);
    setState(() => gldState = newState);
  }
}

class TodoListCommon extends InheritedWidget {
  final RoutineListData rldState;
  final GoalListData gldState;
  final _TodoListWrapperState stateWidget;

  const TodoListCommon({
    Key key,
    @required Widget child,
    @required this.gldState,
    @required this.rldState,
    @required this.stateWidget,
  }) : super(child: child);

  static _TodoListWrapperState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TodoListCommon>().stateWidget;

  @override
  bool updateShouldNotify(TodoListCommon oldWidget) {
    return oldWidget.gldState != gldState;
  }
}
