import 'package:collection/collection.dart';
import 'package:rewind_app/database/database_provider.dart';
import 'package:rewind_app/models/regular_tasks.dart';
import 'package:rewind_app/models/task.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class GoalListData {
  List<Task> tasks;
  DeepCollectionEquality deepEq;

  GoalListData({
    tasks,
    deepEq,
  }) {
    this.tasks = tasks;
    this.deepEq = DeepCollectionEquality();
  }

  /*GoalListData.initializeFromDB() {
    DatabaseProvider.db.getTasks().then((value) => this.tasks = value);
    this.deepEq = DeepCollectionEquality();
  }*/

  GoalListData copy({
    List<int> numbers,
    List<RegularTask> regularTasks,
    List<Task> tasks,
  }) =>
      GoalListData(
        tasks: tasks ?? this.tasks,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalListData &&
          runtimeType == other.runtimeType &&
          deepEq.equals(tasks, other.tasks);

  @override
  int get hashCode => super.hashCode;
}
