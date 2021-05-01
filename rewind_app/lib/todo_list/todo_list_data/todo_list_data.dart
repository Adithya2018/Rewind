import 'package:rewind_app/todo_list/tdl_common.dart';

class TodoListData {
  final List<int> numbers;
  final List<RegularTask> regularTasks;
  final List<Task> tasks;

  const TodoListData({
    this.numbers = const [0, 1, 2],
    this.regularTasks = const [],
    this.tasks = const [],
  });

  TodoListData copy({
    List<int> numbers,
    List<RegularTask> regularTasks,
    List<Task> tasks,
  }) =>
      TodoListData(
        numbers: numbers ?? this.numbers,
        regularTasks: regularTasks ?? this.regularTasks,
        tasks: tasks ?? this.tasks,
      );
  bool areListsEqual(var list1, var list2) {
    // check if both are lists
    if (!(list1 is List && list2 is List)
        // check if both have same length
        ||
        list1.length != list2.length) {
      return false;
    }

    // check if elements are equal
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }
    return true;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoListData &&
          runtimeType == other.runtimeType &&
          areListsEqual(numbers, other.numbers);

  @override
  int get hashCode => super.hashCode;
}
