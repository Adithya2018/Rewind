import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  DateTime created;

  @HiveField(1)
  int orderIndex;

  @HiveField(2)
  String label;

  @HiveField(3)
  String description;

  @HiveField(4)
  DateTime deadline;

  @HiveField(5)
  int level;

  @HiveField(6)
  bool completionStatus;

  @HiveField(7)
  DateTime completed;

  Task() {
    orderIndex = 0;
    label = "";
    description = "";
    deadline = null;
    created = null;
    level = 1;
    completionStatus = false;
    completed = null;
  }
  Task.fromTask(Task task) {
    this.orderIndex = task.orderIndex;
    this.label = task.label;
    this.description = task.description;
    this.deadline = task.deadline;
    this.level = task.level;
    this.created = task.created;
    this.completionStatus = task.completionStatus;
    this.completed = task.completed;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      /*DatabaseProvider.COLUMN_LABEL: label,
      DatabaseProvider.COLUMN_DESCRIPTION: description,*/
    };
    /*if(orderIndex!=null){
      map[DatabaseProvider.COLUMN_ID] = orderIndex;
    }*/
    return map;
  }

  Task.fromMap(Map<String, dynamic> map){
    /*orderIndex = map[DatabaseProvider.COLUMN_ID];
    label = map[DatabaseProvider.COLUMN_LABEL];
    description = map[DatabaseProvider.COLUMN_DESCRIPTION];*/
  }
}