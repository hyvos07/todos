// ignore_for_file: empty_constructor_bodies, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/config/colorconfig.dart';
import 'package:todos/homepage_widget/single_task.dart';
import 'package:todos/object/task.dart';
import 'package:todos/object/taskvault.dart';

class CompletedTask extends StatelessWidget {
  const CompletedTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get the list of completed tasks
    List<Task> completedTasks = Provider.of<TaskVault>(context).completedTasks;
    List<Widget> completedList = [];

    // Convert and add the completed task to the list of widget
    for (int i = 0; i < completedTasks.length; i++) {
      completedList.add(SingleTask(
        task: completedTasks[i],
      ));
    }

    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 1),
                child: Text(
                  "Completed Task",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    height: 0.05,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 1),
                child: Text(
                  "${completedList.length} Tasks",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0.05,
                  ),
                ),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 17.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: content(completedList), // Determine what to show
            ),
          )
        ],
      ),
    );
  }

  // Function to determine if there is any completed task
  List<Widget> content(List<Widget> completedList) {
    if (completedList.isEmpty) {
      // No completed task ==> display a message
      return [
        Container(
          height: 100,
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "There is no completed task yet!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: cLightPurple,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Are you procastinating?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: cLightPurple,
                  fontSize: 13,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        )
      ];
    }

    return completedList; // Completed task exists, display that list of widget
  }
}
