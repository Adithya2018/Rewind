import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rewind_app/models/interval.dart';
import 'interval.dart';
part 'regular_task.g.dart';

@HiveType(typeId: 1)
class RegularTask extends HiveObject {
  @HiveField(0)
  DateTime? created;

  @HiveField(1)
  int? orderIndex;

  @HiveField(2)
  String? label;

  @HiveField(3)
  String? description;

  @HiveField(4)
  bool? weekly;

  @HiveField(5)
  List<List<TimeInterval>>? weeklyRepeat;

  @HiveField(6)
  Map? customRepeat;

  @HiveField(7)
  int? level;

  @HiveField(8)
  bool? completionStatus;

  DateTime? get createdDateTime => created == null ? DateTime.now() : created;

  RegularTask() {
    orderIndex = 0;
    label = "";
    description = "";
    weekly = true;
    weeklyRepeat = newWeekRepeat;
    customRepeat = newCustomRepeat;
    level = 1;
    completionStatus = false;
  }

  @override
  String toString() {
    List<String> result = [];
    result.add("created: ${created.toString()}");
    result.add("title: $label");
    result.add("description: ${description!.isEmpty?"no description":description}");
    result.add("weeklyRepeat: ${weeklyRepeat.toString()}");
    result.add("level: $level");
    result.add("completionStatus: ${completionStatus!?"":"not"} completed");
    String s = "";
    result.forEach((element) {
      s += "$element\n";
    });
    return s;
  }

  static Map<String, int?> get newCustomRepeat {
    return {
      "startDate": null,
      "rptEvery": 1,
      "nRpt": -1,
    };
  }

  static Map<String, int?> get newTime {
    return {
      "hh": null,
      "mm": null,
    };
  }

  static List<List<TimeInterval>> get newWeekRepeat {
    return List<List<TimeInterval>>.generate(
      7,
      (index) => List<TimeInterval>.from([]),
    );
  }

  static TimeOfDay toTimeOfDay(Map<String, int> map) {
    return TimeOfDay(
      hour: map['hh']!,
      minute: map['mm']!,
    );
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
}
