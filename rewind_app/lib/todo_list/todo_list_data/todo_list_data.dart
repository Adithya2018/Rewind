import 'package:collection/collection.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class GoalListData {
  final List<int> numbers;
  final List<RegularTask> regularTasks;
  final List<Task> tasks;
  final deepEq;

  const GoalListData({
    this.numbers = const [0, 1, 2],
    this.regularTasks = const [],
    this.tasks = const [],
    this.deepEq = const DeepCollectionEquality(),
  });

  GoalListData copy({
    List<int> numbers,
    List<RegularTask> regularTasks,
    List<Task> tasks,
  }) =>
      GoalListData(
        numbers: numbers ?? this.numbers,
        regularTasks: regularTasks ?? this.regularTasks,
        tasks: tasks ?? this.tasks,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalListData &&
          runtimeType == other.runtimeType &&
          deepEq.equals(numbers, other.numbers) &&
          deepEq.equals(tasks, other.tasks) &&
          deepEq.equals(regularTasks, other.regularTasks);

  @override
  int get hashCode => super.hashCode;
}
