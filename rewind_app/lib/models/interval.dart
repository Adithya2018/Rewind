import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'interval.g.dart';

@HiveType(typeId: 2)
class TimeInterval extends HiveObject {
  @HiveField(0)
  Map<String, int> startTime;
  @HiveField(1)
  Map<String, int> endTime;
  TimeInterval() {
    startTime = newTime;
    endTime = newTime;
  }
  TimeInterval.fromTimes(TimeOfDay t1, TimeOfDay t2) {
    startTime = mapToTimeOfDay(t1);
    endTime = mapToTimeOfDay(t2);
  }
  static Map<String, int> get newTime => {
        "hh": null,
        "mm": null,
      };

  static mapToTimeOfDay(TimeOfDay timeOfDay) {
    return {
      "hh": timeOfDay.hour,
      "mm": timeOfDay.minute,
    };
  }

  static TimeOfDay toTimeOfDay(Map<String, int> map) {
    return TimeOfDay(
      hour: map['hh'],
      minute: map['mm'],
    );
  }

  @override
  String toString(){
    List<String> list = [];
    list.add(startTime['hh'].toString());
    list.add(":");
    list.add(startTime['mm'].toString());
    list.add(" to ");
    list.add(endTime['hh'].toString());
    list.add(":");
    list.add(endTime['mm'].toString());
    String result = "";
    list.forEach((element) {
      result += "$element";
    });
    return result;
  }

  bool containsTime(TimeOfDay timeOfDay) {
    bool b1 = startTime['hh'] < timeOfDay.hour ||
        (startTime['hh'] == timeOfDay.hour &&
            startTime['mm'] <= timeOfDay.minute);
    bool b2 = timeOfDay.hour < endTime['hh'] ||
        (timeOfDay.hour == endTime['hh'] && timeOfDay.minute <= endTime['mm']);
    return b1 && b2;
  }
}
