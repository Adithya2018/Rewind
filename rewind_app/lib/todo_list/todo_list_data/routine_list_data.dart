import 'package:collection/collection.dart';
import 'package:rewind_app/models/regular_task/regular_task.dart';

class RoutineListData {
  List<RegularTask>? regularTasks;
  late DeepCollectionEquality deepEq;
  bool? ascendingOrder;

  Function currentSortByFunction(int sortByOption, bool ascendingOrder) {
    return (RegularTask a, RegularTask b) =>
        (ascendingOrder ? 1 : -1) * _sortByFunction[sortByOption](a, b) as int;
  }

  List<Function> _sortByFunction = [
    //(RegularTask a, RegularTask b) => a.deadline.compareTo(b.deadline),
    (RegularTask a, RegularTask b) => a.level!.compareTo(b.level!),
  ];
  /*const RoutineListData({
    this.regularTasks = const [],
    this.deepEq = const DeepCollectionEquality(),
  });*/

  RoutineListData({
    List<RegularTask>? regularTasks,
    bool? ascendingOrder,
  }) {
    this.regularTasks = regularTasks;
    this.ascendingOrder = ascendingOrder;
  }

  /*RoutineListData.initializeFromDB() {
    DatabaseProvider.db.getRegularTasks().then((value) {
      print("$value");
      this.regularTasks = value;
    });
    this.deepEq = DeepCollectionEquality();
  }*/

  RoutineListData copy({
    List<RegularTask>? regularTasks,
    bool? ascendingOrder,
  }) =>
      RoutineListData(
        regularTasks: regularTasks ?? this.regularTasks,
        ascendingOrder: ascendingOrder ?? this.ascendingOrder,
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
