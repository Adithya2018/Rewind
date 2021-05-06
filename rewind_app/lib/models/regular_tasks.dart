import 'package:hive/hive.dart';
import 'package:rewind_app/todo_list/tdl_common.dart';
part 'regular_tasks.g.dart';

@HiveType(typeId: 1)
class RegularTask {
  @HiveField(0)
  DateTime created;

  @HiveField(1)
  int orderIndex;

  @HiveField(2)
  String label;

  @HiveField(3)
  String description;

  @HiveField(4)
  bool weekly;

  @HiveField(5)
  List<DayAndTime> weeklyRepeat;

  @HiveField(6)
  Map customRepeat;

  @HiveField(7)
  int level;

  @HiveField(8)
  bool completionStatus;

  RegularTask() {
    created = DateTime.now();
    orderIndex = 0;
    label = "";
    description = "";
    weekly = true;
    weeklyRepeat = List<DayAndTime>.generate(
      7,
          (index) => DayAndTime(index + 1),
    );
    customRepeat = {
      "startDate": null,
      "rptEvery": 1,
      "nRpt": -1,
    };
    level = 1;
    completionStatus = false;
  }

  RegularTask.fromRegularTask(RegularTask regularTask) {
    this.created = regularTask.created;
    this.orderIndex = regularTask.orderIndex;
    this.label = regularTask.label;
    this.description = regularTask.description;
    this.weekly = regularTask.weekly;
    this.weeklyRepeat = regularTask.weeklyRepeat;
    this.customRepeat = regularTask.customRepeat;
    this.level = regularTask.level;
    this.completionStatus = regularTask.completionStatus;
  }

  /*RegularTask.fromMap(Map<String, Object> map) {
    orderIndex = 0;
    created = map[TableRoutine.COLUMN_CREATED];
    label = map[TableRoutine.COLUMN_LABEL];
    description = map[TableRoutine.COLUMN_DESCRIPTION];
    weekly = map[TableRoutine.COLUMN_WEEKLY];
    weeklyRepeat = map[TableRoutine.COLUMN_WEEKLY_REPEAT];
    customRepeat = map[TableRoutine.COLUMN_CUSTOM_REPEAT];
    level = map[TableRoutine.COLUMN_LEVEL];
    completionStatus = map[TableRoutine.COLUMN_COMPLETION_STATUS];
  }*/
}