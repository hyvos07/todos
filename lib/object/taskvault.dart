// ignore_for_file: prefer_final_fields

import "package:flutter/foundation.dart";
import "package:todos/object/task.dart";

class TaskVault with ChangeNotifier {
  // Dummy Data - Temporary
  List<Task> _listOfTasks = [
    Task(
      id: "1",
      taskTitle: "Finish the UI Design",
      taskDescription: "Finish the UI Design for the app",
      taskDone: false,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Task(
      id: "2",
      taskTitle: "Meeting with the Client",
      taskDescription: "Meeting with the client to discuss the project",
      taskDone: false,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 7)),
    ),
    Task(
      id: "3",
      taskTitle: "Prepare the Presentation",
      taskDescription: "Prepare the presentation for the meeting",
      taskDone: false,
      startDate: DateTime.now().subtract(const Duration(days: 3)),
      endDate: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Task(
      id: "4",
      taskTitle: "Send the Report",
      taskDescription: "Send the report to the client",
      taskDone: false,
      startDate: DateTime.now().subtract(const Duration(days: 3)),
      endDate: DateTime.now().subtract(const Duration(days: 7)),
    ),
  ];

  List<Task> _onGoingTasks = [];
  List<Task> _completedTasks = [];

  List<Task> get listOfTasks => _listOfTasks;
  List<Task> get onGoingTasks => _onGoingTasks;
  List<Task> get completedTasks => _completedTasks;

  // Auto load the tasks into the ongoing and completed list
  TaskVault() {
    refreshTask();
  }

  // Change the ongoing/completed status of the task
  void onChanged(Task task) {
    task.taskDone = !task.taskDone;
    refreshTask();
  }

  // Delete the existing task
  void onDeleted(String idTask) {
    _listOfTasks.removeWhere((task) => task.id == idTask);
    refreshTask();
  }

  // Add new task
  void addTask(Task task) {
    _listOfTasks.add(task);
    refreshTask();
  }

  // Refresh the task list
  void refreshTask() {
    sortTask();
    _onGoingTasks = [];
    _completedTasks = [];
    for (int i = 0; i < _listOfTasks.length; i++) {
      if (_listOfTasks[i].taskDone == false) {
        onGoingTasks.add(_listOfTasks[i]);
      } else {
        completedTasks.add(_listOfTasks[i]);
      }
    }
    notifyListeners();
  }

  // -- Sort Task -- //
  // Using Bubble Sort, the function will sort the task by the smallest due date
  void sortTask() {
    for (int i = 0; i < _listOfTasks.length - 1; i++) {
      for (int j = 0; j < _listOfTasks.length - i - 1; j++) {
        if (_listOfTasks[j].getDueValue() > _listOfTasks[j + 1].getDueValue()) {
          Task temp = _listOfTasks[j];
          _listOfTasks[j] = _listOfTasks[j + 1];
          _listOfTasks[j + 1] = temp;
        }
      }
    }
  }
}
