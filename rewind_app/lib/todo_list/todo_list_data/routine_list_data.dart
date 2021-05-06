import 'package:collection/collection.dart';
import 'package:rewind_app/database/database_provider.dart';
import 'package:rewind_app/models/regular_tasks.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';

class RoutineListData {
  List<RegularTask> regularTasks;
  DeepCollectionEquality deepEq;

  /*const RoutineListData({
    this.regularTasks = const [],
    this.deepEq = const DeepCollectionEquality(),
  });*/

  RoutineListData({
    regularTasks,
  }) {
    this.regularTasks = regularTasks;
  }

  /*RoutineListData.initializeFromDB() {
    DatabaseProvider.db.getRegularTasks().then((value) {
      print("$value");
      this.regularTasks = value;
    });
    this.deepEq = DeepCollectionEquality();
  }*/

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
