import 'package:collection/collection.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class RoutineListData {
  final List<RegularTask> regularTasks;
  final deepEq;

  const RoutineListData({
    this.regularTasks = const [],
    this.deepEq = const DeepCollectionEquality(),
  });

  RoutineListData copy({
    List<RegularTask> regularTasks,
  }) =>
      RoutineListData(
        regularTasks: regularTasks ?? this.regularTasks,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RoutineListData &&
              runtimeType == other.runtimeType &&
              deepEq.equals(regularTasks, other.regularTasks);

  @override
  int get hashCode => super.hashCode;
}
