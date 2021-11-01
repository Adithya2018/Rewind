import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/models/regular_task/regular_task.dart';
import 'package:rewind_app/models/task/task.dart';
import 'package:rewind_app/todo_list/todo_list_data/routine_list_data.dart';
import 'package:rewind_app/todo_list/todo_list_data/goal_list_data.dart';

class TodoListWrapper extends StatefulWidget {
  final Widget child;
  const TodoListWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  _TodoListWrapperState createState() => _TodoListWrapperState();
}

class _TodoListWrapperState extends State<TodoListWrapper> {
  GoalListData? gldState;
  RoutineListData? rldState;
  static const GOAL_BOX_NAME = 'goals';
  static const ROUTINE_BOX_NAME = 'routine';

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
    gldState = GoalListData(
      tasks: List<Task>.from(Hive.box(GOAL_BOX_NAME).values),
      sortByOption: 0,
      ascendingOrder: true,
    );
    /*print("goals=${gldState.tasks.length}");
    gldState.tasks.forEach((element) {
      print("goal: ${element.toString()}");
    });*/
    rldState = RoutineListData(
      regularTasks: List<RegularTask>.from(Hive.box(ROUTINE_BOX_NAME).values),
      ascendingOrder: true,
    );
    /*print("regular tasks=${rldState.regularTasks.length}");
    rldState.regularTasks.forEach((element) {
      print("regular task: ${element.toString()}");
    });*/
  }

  @override
  void dispose() {
    //Created: 2021-05-07 05:04:04.204453
    gldState!.tasks!.forEach((task) {
      saveToBox(task.created!, task, GOAL_BOX_NAME);
    });
    rldState!.regularTasks!.forEach((task) {
      saveToBox(task.created!, task, ROUTINE_BOX_NAME);
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

  void sortTasks() {
    List<Task> tasks = List<Task>.from(gldState!.tasks!);
    tasks.sort(gldState!.currentSortByFunction as int Function(Task, Task)?);
    int id = 0;
    tasks.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState!.copy(tasks: tasks));
  }

  void sortRegularTasks(Function f) {
    List<RegularTask> regularTasks =
        List<RegularTask>.from(rldState!.regularTasks!);
    regularTasks.sort(f as int Function(RegularTask, RegularTask)?);
    int id = 0;
    regularTasks.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => rldState = rldState!.copy(regularTasks: regularTasks));
  }

  void addTask(Task task) {
    List<Task> newList = [task] + gldState!.tasks!;
    //newList.sort(gldState.currentSortByFunction);
    int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => gldState = gldState!.copy(tasks: newList));
  }

  void switchRegularTaskCompletionStatus(int index) {
    List<RegularTask> newList = rldState!.regularTasks!;
    newList[index].completionStatus = !newList[index].completionStatus!;
    setState(() => rldState = rldState!.copy(regularTasks: newList));
  }

  void removeRegularTask(RegularTask regularTask) {
    List<RegularTask>? newList = rldState!.regularTasks;
    setState(() => rldState = rldState!.copy(regularTasks: newList));
  }

  void addRegularTask(RegularTask regularTask) {
    List<RegularTask> newList = rldState!.regularTasks! + [regularTask];
    newList.sort((RegularTask a, RegularTask b) => a.level!.compareTo(b.level!));
    int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });
    setState(() => rldState = rldState!.copy(regularTasks: newList));
  }

  @override
  Widget build(BuildContext context) => TodoListCommon(
        child: widget.child,
        gldState: gldState,
        rldState: rldState,
        stateWidget: this,
      );

  void sortTasksBy(int? temp) {
    gldState!.sortByOption = temp;
    sortTasks();
  }

  void switchTaskListOrder() {
    gldState!.ascendingOrder = !gldState!.ascendingOrder!;
  }
}

class TodoListCommon extends InheritedWidget {
  final RoutineListData? rldState;
  final GoalListData? gldState;
  final _TodoListWrapperState stateWidget;

  const TodoListCommon({
    Key? key,
    required Widget child,
    required this.gldState,
    required this.rldState,
    required this.stateWidget,
  }) : super(child: child);

  static _TodoListWrapperState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TodoListCommon>()!.stateWidget;

  @override
  bool updateShouldNotify(TodoListCommon oldWidget) {
    return oldWidget.gldState != gldState;
  }
}
