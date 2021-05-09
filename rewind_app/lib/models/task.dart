import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
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
    level = 1;
    completionStatus = false;
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

  DateTime get createdDateTime => created == null ? DateTime.now() : created;

  @override
  String toString() {
    List<String> result = [];
    result.add("created: ${created.toString()}");
    result.add("title: $label");
    result.add("description: ${description.isEmpty?"no description":description}");
    result.add("deadline: ${deadline.toString()}");
    result.add("level: $level");
    result.add("completionStatus: ${completionStatus?"":"not"} completed");
    result.add("completed: ${completed.toString()}");
    String s = "";
    result.forEach((element) {
      s += "$element\n";
    });
    return s;
  }
}
