import 'package:flutter/material.dart';

class DayAndTime {
  int weekDay;
  List<TimeOfDay> time;

  DayAndTime.fromDay(int day) {
    this.weekDay = day;
    time = [];
  }

  DayAndTime({this.weekDay, this.time});
}
