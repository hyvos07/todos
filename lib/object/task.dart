// ignore_for_file: prefer_final_fields

// Class Task to implement OOP concepts, making storing and retrieving data easier

import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:todos/config/colorconfig.dart';

part "task.g.dart"; // Build runner

@HiveType(typeId: 0) // Hive type ID
class Task {
  @HiveField(0) // Hive field ID
  String? id; // ID will use "ID<milisecond from epoch time>"
  @HiveField(1)
  String? taskTitle;
  @HiveField(2)
  String? taskDescription;
  @HiveField(3)
  bool taskDone;
  @HiveField(4)
  DateTime startDate;
  @HiveField(5)
  DateTime endDate;

  Task({
    required this.id,
    required this.taskTitle,
    required this.taskDescription,
    required this.startDate,
    required this.endDate,
    this.taskDone = false, // Default value == Not done
  });

  // static List<Task> todoList() {
  //   return [];
  // }

  // Getter for the due date: "The task is due for <due date>" or else
  String getDue() {
    List<Object> due = decideDue();
    String taskDue = due[0] as String;
    String daysDifference = due[1] as String;

    return "$taskDue $daysDifference";
  }

  // Getter for the due date in days
  String getDueDays() {
    List<Object> due = decideDue();
    String daysDifference = due[1] as String;

    return daysDifference;
  }

  // Getter for the due date color: cLightPurple for positive, cRed for negative
  Color getDueColor() {
    List<Object> due = decideDue();
    Color taskDueColor = due[2] as Color;

    return taskDueColor;
  }

  // Getter for the due date in number of days
  int getDueValue() {
    List<Object> due = decideDue();
    int difference = due[3] as int;

    return difference;
  }

  // Decide the due date; all getter will use this method
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

  // Setter to change the task title
  // (just in case if task object's fields are unaccessible)
  void setTaskTitle(String title) {
    taskTitle = title;
  }
}
