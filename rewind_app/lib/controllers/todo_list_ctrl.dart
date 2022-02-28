import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/models/regular_task/regular_task.dart';
import 'package:rewind_app/models/task/task.dart';
import 'package:rewind_app/todo_list/todo_list_data/routine_list_data.dart';
import 'package:rewind_app/todo_list/todo_list_data/goal_list_data.dart';

class TodoListController extends GetxController {
  late GoalListData gldState;
  late RoutineListData rldState;

  static const GOALS_BOX_NAME = 'goals';
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
  void onInit() {
    super.onInit();
    String boxNameSuffix = ''; //widget.boxNameSuffix!;
    print("todo list state initState()");
    print(boxNameSuffix + GOALS_BOX_NAME);
    gldState = GoalListData(
      tasks: List<Task>.from(
        Hive.box(boxNameSuffix + GOALS_BOX_NAME).values,
      ),
      sortByOption: 0,
      ascendingOrder: true,
    );
    print(boxNameSuffix + ROUTINE_BOX_NAME);
    rldState = RoutineListData(
      regularTasks: List<RegularTask>.from(
        Hive.box(boxNameSuffix + ROUTINE_BOX_NAME).values,
      ),
      ascendingOrder: true,
    );
  }

  @override
  void dispose() {
    gldState.tasks!.forEach((task) {
      saveToBox(
        task.created!,
        task,
        GOALS_BOX_NAME,
      );
    });
    rldState.regularTasks!.forEach((task) {
      saveToBox(
        task.created!,
        task,
        ROUTINE_BOX_NAME,
      );
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
    List<Task> tasks = List<Task>.from(gldState.tasks!);
    tasks.sort(gldState.currentSortByFunction as int Function(Task, Task)?);
    int id = 0;
    tasks.forEach((element) {
      element.orderIndex = id++;
    });
    //setState(() => gldState = gldState!.copy(tasks: tasks));
  }

  void sortRegularTasks(Function f) {
    List<RegularTask> regularTasks =
        List<RegularTask>.from(rldState.regularTasks!);
    regularTasks.sort(f as int Function(RegularTask, RegularTask)?);
    int id = 0;
    regularTasks.forEach((element) {
      element.orderIndex = id++;
    });
    //setState(() => rldState = rldState!.copy(regularTasks: regularTasks));
  }

  void addTask(Task task) {
    List<Task> newList = [task] + gldState.tasks!;
    //newList.sort(gldState;
    int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });
    //setState(() => gldState = gldState!.copy(tasks: newList));
  }

  void switchRegularTaskCompletionStatus(int index) {
    List<RegularTask> newList = rldState.regularTasks!;
    newList[index].completionStatus = !newList[index].completionStatus!;
    //setState(() => rldState = rldState!.copy(regularTasks: newList));
  }

  void removeRegularTask(RegularTask regularTask) {
    List<RegularTask>? newList = rldState.regularTasks;
    newList!.remove(regularTask);
    //setState(() => rldState = rldState!.copy(regularTasks: newList));
  }

  void addRegularTask(RegularTask regularTask) {
    List<RegularTask> newList = [regularTask] + rldState.regularTasks!;
    newList
        .sort((RegularTask a, RegularTask b) => a.level!.compareTo(b.level!));
    int id = 0;
    newList.forEach((element) {
      element.orderIndex = id++;
    });
    // setState(() => rldState = rldState!.copy(regularTasks: newList));
  }

  void sortTasksBy(int? temp) {
    gldState.sortByOption = temp;
    sortTasks();
  }

  void switchTaskListOrder() {
    gldState.ascendingOrder = !gldState.ascendingOrder!;
  }
}
