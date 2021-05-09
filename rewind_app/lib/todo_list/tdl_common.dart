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

  List<String> weekDayAbbr = [
    "Mon",
    "Tues",
    "Wed",
    "Thurs",
    "Fri",
    "Sat",
    "Sun",
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

  String formatDate(DateTime dateTime, {bool abbr = false}) {
    List<String> list = abbr ? weekDayAbbr : weekDay;
    String result =
        "${list[dateTime.weekday - 1]}, ${dateTime.day} ${month[dateTime.month - 1]}";
    String year =
        DateTime.now().year == dateTime.year ? "" : " ${dateTime.year}";
    return "$result$year";
  }

  static DateTime dateTimeShortened(DateTime dateTime){
    dateTime = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
    );
    return dateTime;
  }
  //var daySuffix = ["st", "nd", "rd", "th",];
  /*String currentDateAndTime() {
    DateTime now = new DateTime.now();
    return "${weekDay[now.weekday - 1]}, ${now.day} ${month[now.month - 1]} ${now.year}";
  }*/
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
/*Row(
            children: List.generate(
              numberIcons.length,
              (i) => Icon(
                numberIcons[i],
              ),
            ),
          ),*/
/*List<IconData> numberIcons = [
      MaterialCommunityIcons.numeric_1_box,
      MaterialCommunityIcons.numeric_2_box,
      MaterialCommunityIcons.numeric_3_box,
      MaterialCommunityIcons.numeric_4_box,
      MaterialCommunityIcons.numeric_5_box,
      MaterialCommunityIcons.numeric_6_box,
      MaterialCommunityIcons.numeric_7_box,
      MaterialCommunityIcons.numeric_8_box,
      MaterialCommunityIcons.numeric_9_box,
    ];*/
