// ignore_for_file: prefer_final_fields

import 'dart:ui';

import 'package:todos/config/colorconfig.dart';

class Task {
  String? id; // ID will use "ID<milisecond from epoch time>"
  String? taskTitle;
  String? taskDescription;
  bool taskDone;
  DateTime startDate;
  DateTime endDate;

  Task({
    required this.id,
    required this.taskTitle,
    required this.taskDescription,
    required this.startDate,
    required this.endDate,
    this.taskDone = false, // Default value == Not done
  });

  static List<Task> todoList() {
    return [];
  }

  String getDue() {
    List<Object> due = decideDue();
    String taskDue = due[0] as String;
    String daysDifference = due[1] as String;

    return "$taskDue $daysDifference";
  }

  Color getDueColor() {
    List<Object> due = decideDue();
    Color taskDueColor = due[2] as Color;

    return taskDueColor;
  }

  int getDueValue() {
    List<Object> due = decideDue();
    int difference = due[3] as int;

    return difference;
  }

  List<Object> decideDue() {
    DateTime now = DateTime.now();

    DateTime nowDateDays = DateTime(now.year, now.month, now.day);

    DateTime endDateDays = DateTime(endDate.year, endDate.month, endDate.day);

    Duration difference = endDateDays.difference(nowDateDays);
    String daysDifference = "${difference.inDays} days";

    String taskDue = "This task is due for";
    Color taskDueColor = const Color(0xFF5038BC);

    if (difference.inDays == 0) {
        daysDifference = "Today";
        taskDueColor = cLightPurple;
    } else if (now.isBefore(endDate)) {
        daysDifference = "${difference.inDays} days";
        taskDueColor = cLightPurple;
    } else if (daysDifference.substring(0, 1) == "-") {
        daysDifference = daysDifference.substring(1);
        taskDue = "This task is already due for";
        taskDueColor = cRed;
    }
    return [taskDue, daysDifference, taskDueColor, difference.inDays];
  }
}
