import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class DateAndTimeFormat {
  List<String> month = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  List<String> weekDay = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  List<String> weekDayLetter = [
    "M",
    "T",
    "W",
    "T",
    "F",
    "S",
    "S",
  ];

  List<IconData> weekDayIcon = [
    MaterialCommunityIcons.alpha_m_box,
    MaterialCommunityIcons.alpha_t_box,
    MaterialCommunityIcons.alpha_w_box,
    MaterialCommunityIcons.alpha_t_box,
    MaterialCommunityIcons.alpha_f_box,
    MaterialCommunityIcons.alpha_s_box,
    MaterialCommunityIcons.alpha_s_box,
  ];

  String formatTime(TimeOfDay timeOfDay) {
    String minute = timeOfDay.minute < 10 ? "0" : "";
    minute += "${timeOfDay.minute}";
    bool beforeMidday = timeOfDay.hour < 12;
    int hour = timeOfDay.hour;
    if (!beforeMidday) {
      hour -= 12;
    }
    hour = hour == 0 ? 12 : hour;
    return "$hour:$minute ${beforeMidday ? "AM" : "PM"}";
  }

  String formatDate(DateTime dateTime) {
    String result =
        "${weekDay[dateTime.weekday - 1]}, ${dateTime.day} ${month[dateTime.month - 1]}";
    String year =
        DateTime.now().year == dateTime.year ? "" : " ${dateTime.year}";
    return "$result$year";
  }
  //var daySuffix = ["st", "nd", "rd", "th",];
  /*String currentDateAndTime() {
    DateTime now = new DateTime.now();
    return "${weekDay[now.weekday - 1]}, ${now.day} ${month[now.month - 1]} ${now.year}";
  }*/
}

class Task {
  int orderIndex;
  String label;
  String description;
  DateTime deadline;
  int level;
  DateTime created;
  bool completionStatus;
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
}

class RegularTask {
  int orderIndex;
  String label;
  String description;
  List<DayAndTime> weeklyRepeat;
  int level;
  bool completionStatus;
  RegularTask() {
    orderIndex = 0;
    label = "";
    description = "";
    weeklyRepeat = List<DayAndTime>.generate(
      7,
      (index) => DayAndTime(index + 1),
    );
    level = 1;
    completionStatus = false;
  }
  RegularTask.fromRegularTask(RegularTask regularTask) {
    this.orderIndex = regularTask.orderIndex;
    this.label = regularTask.label;
    this.description = regularTask.description;
    this.weeklyRepeat = regularTask.weeklyRepeat;
    this.level = regularTask.level;
    this.completionStatus = regularTask.completionStatus;
  }
}

class DayAndTime {
  int day;
  List<TimeOfDay> time;
  DayAndTime(int day) {
    this.day = day;
    time = [];
  }
}

class TaskLevel {
  List<Color> diffLevelIconColor = [
    Color(0xFF0026F9),
  ];

  List<IconData> diffLevelIcon = [
    MaterialCommunityIcons.tea,
    MaterialCommunityIcons.cake_variant,
    MaterialCommunityIcons.alarm_light,
    MaterialCommunityIcons.bomb,
    MaterialCommunityIcons.skull,
  ];

  List<IconData> diffLevelNumeric = [
    MaterialCommunityIcons.numeric_1_box,
    MaterialCommunityIcons.numeric_2_box,
    MaterialCommunityIcons.numeric_3_box,
    MaterialCommunityIcons.numeric_4_box,
    MaterialCommunityIcons.numeric_5_box,
  ];

  List<Color> diffLevelNumericColor = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.yellowAccent,
    Colors.orangeAccent,
    Colors.redAccent,
  ];

  List<String> diffLevelText = [
    "My cup of tea",
    "A piece of cake",
    "Are you sure?",
    "Good luck!",
    "Good luck++",
  ];
}
