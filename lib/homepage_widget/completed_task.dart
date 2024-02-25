// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:todos/homepage_widget/single_task.dart';

class CompletedTask extends StatelessWidget {
  const CompletedTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> completedTasks = [
      const SingleTask(taskName: 'Tasks', taskDone: true),
      const SingleTask(taskName: 'Tasks', taskDone: true),
      const SingleTask(taskName: 'Tasks', taskDone: true),
      const SingleTask(taskName: 'Tasks', taskDone: true),
      const SingleTask(taskName: 'Tasks', taskDone: true),
      const SingleTask(taskName: 'Tasks', taskDone: true),
      const SingleTask(taskName: 'Tasks', taskDone: true),
      const SingleTask(taskName: 'Tasks', taskDone: true),
      const SingleTask(taskName: 'Tasks', taskDone: true),
    ];

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
                  "${completedTasks.length} Tasks",
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
              children: completedTasks,
            ),
          )
        ],
      ),
    );
  }
}
