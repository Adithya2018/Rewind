import 'package:collection/collection.dart';
import 'package:rewind_app/models/regular_task/regular_task.dart';
import 'package:rewind_app/models/task/task.dart';

class GoalListData {
  List<Task>? tasks;
  bool? ascendingOrder = true;
  int? sortByOption;
  DeepCollectionEquality deepEq = DeepCollectionEquality();
  List<Function> sortByFunction = [
    (Task a, Task b) => a.created!.compareTo(b.created!),
    (Task a, Task b) => a.deadline!.compareTo(b.deadline!),
    (Task a, Task b) => a.level!.compareTo(b.level!),
  ];
  Set<int>? selected;
  Function get currentSortByFunction => (Task a, Task b) =>
      (ascendingOrder! ? 1 : -1) * sortByFunction[sortByOption!](a, b) as int;

  GoalListData({
    List<Task>? tasks,
    Set<int>? selected,
    int? sortByOption,
    bool? ascendingOrder,
  }) {
    this.tasks = tasks;
    this.selected = selected;
    this.sortByOption = sortByOption;
    this.ascendingOrder = ascendingOrder;
  }

  GoalListData copy({
    List<Task>? tasks,
    Set<int>? selected,
    int? sortByOption,
    bool? ascendingOrder,
  }) =>
      GoalListData(
        tasks: tasks ?? this.tasks,
        selected: selected ?? this.selected,
        sortByOption: sortByOption ?? this.sortByOption,
        ascendingOrder: ascendingOrder ?? this.ascendingOrder,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalListData &&
          runtimeType == other.runtimeType &&
          deepEq.equals(tasks, other.tasks) &&
          deepEq.equals(selected, other.selected) &&
          sortByOption == other.sortByOption &&
          ascendingOrder == other.ascendingOrder;

  @override
  int get hashCode => super.hashCode;
}
