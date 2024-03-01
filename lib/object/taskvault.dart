// ignore_for_file: prefer_final_fields

import "package:flutter/foundation.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:todos/object/task.dart";

class TaskVault with ChangeNotifier {
  final _taskBox = Hive.box('taskBox');

  List<Task> _listOfTasks = [];

  void loadData() {
    if (_taskBox.get("listOfTasks") == null) {
      // First time opening the app ==> load dummy data
      _listOfTasks = [
        Task(
          id: "IDdummy",
          taskTitle: "Add a new task",
          taskDescription: "Add a new task by clicking the plus button!",
          taskDone: false,
          startDate: DateTime.now(),
          endDate: DateTime.now(),
        ),
      ];
    } else {
      // Load existing data
      _listOfTasks = (_taskBox.get('listOfTasks') as List).cast<Task>();
    }
  }

  List<Task> _onGoingTasks = [];
  List<Task> _completedTasks = [];

  List<Task> get listOfTasks => _listOfTasks;
  List<Task> get onGoingTasks => _onGoingTasks;
  List<Task> get completedTasks => _completedTasks;

  // Auto load the tasks into the ongoing and completed list
  TaskVault() {
    loadData();
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
    _taskBox.put("listOfTasks", _listOfTasks);
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

  // Get Task by ID
  Task getTaskById(String id) {
    return _listOfTasks.firstWhere((task) => task.id == id);
  }
}
