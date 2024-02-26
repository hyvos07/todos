// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:todos/homepage_widget/ongoing_task.dart';
import 'package:todos/homepage_widget/completed_task.dart';
import 'package:todos/object/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> listOfTask = [
    Task(
      id: "1",
      taskTitle: "Finish the UI Design",
      taskDone: false,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Task(
      id: "2",
      taskTitle: "Meeting with the Client",
      taskDone: false,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 3)),
    ),
    Task(
      id: "3",
      taskTitle: "Prepare the Presentation",
      taskDone: false,
      startDate: DateTime.now().subtract(const Duration(days: 3)),
      endDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Task(
      id: "4",
      taskTitle: "Send the Report",
      taskDone: false,
      startDate: DateTime.now().subtract(const Duration(days: 3)),
      endDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  List<Task> onGoingTasks = [];
  List<Task> completedTasks = [];


  @override
  Widget build(BuildContext context) {
    // Get Today's Date; Adding 7 hours to change default UTC timezone to GMT+7
    DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7));
    
    refreshTask(); // Fill the ongoing and completed task list

    return Scaffold(
      backgroundColor: const Color.fromARGB(253, 253, 253, 253),
      appBar: AppBar(
        elevation: 12,
        backgroundColor: Colors.white.withOpacity(0.7),
        scrolledUnderElevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 55,
        centerTitle: true,
        title: Image.asset(
          'images/logofull.png',
          fit: BoxFit.contain,
          height: 44,
        ),
      ),
      body: SafeArea(
        child: Container(
            alignment: Alignment.center,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -- Greeting User -- //
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 50, right: 25, left: 25, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // -- Greetings -- //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${goodWhat(now)}, Daniel!",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 0.05,
                                ),
                              ),
                              // -- Motivational Support -- //
                              Padding(
                                padding: const EdgeInsets.only(top: 28),
                                child: Text(
                                  greet(goodWhat(now)),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0.05,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // -- Menhera-chan -- //
                          Image.asset(
                            menhera(goodWhat(now)),
                            fit: BoxFit.contain,
                            height: 55,
                          ),
                        ],
                      ),
                    ),
                    // -- Ongoing Task -- //
                    OngoingTask(
                      onGoingTasks: onGoingTasks,
                      onChanged: onChanged,
                      onDeleted: onDeleted,
                    ),
                    // -- Completed Task -- //
                    CompletedTask(
                      completedTasks: completedTasks,
                      onChanged: onChanged,
                      onDeleted: onDeleted,
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  // Change the ongoing/completed status of the task
  void onChanged(Task task) {
    setState(() {
      task.taskDone = !task.taskDone;
    });
  }

  // Delete the existing task
  void onDeleted(String idTask) {
    setState(() {
      listOfTask.removeWhere((task) => task.id == idTask);
      refreshTask();
    });
  }

  void refreshTask() {
    setState(() {
      onGoingTasks = [];
      completedTasks = [];
      for (int i = 0; i < listOfTask.length; i++) {
        if (listOfTask[i].taskDone == false) {
          onGoingTasks.add(listOfTask[i]);
        } else {
          completedTasks.add(listOfTask[i]);
        }
      }
    });
  }

  // Greeting User Chooser
  String goodWhat(DateTime date) {
    var hour = date.hour;
    if (hour < 12) {
      return ("Good Morning");
    } else if (hour < 18) {
      return ("Good Afternoon");
    } else {
      return ("Good Evening");
    }
  }

  // Motivational Support Chooser
  String greet(String goodWhat) {
    if (goodWhat == "Good Morning") {
      return "New adventures await you today!";
    } else if (goodWhat == "Good Afternoon") {
      return "Hope you're having a great day!";
    } else {
      return "Nice works for today!";
    }
  }

  // Menhera-chan Chooser
  String menhera(String goodWhat) {
    if (goodWhat == "Good Morning") {
      return "images/morningmenhera.png";
    } else if (goodWhat == "Good Afternoon") {
      return "images/menheracheer.png";
    } else {
      return "images/gnmenhera.png";
    }
  }
}
