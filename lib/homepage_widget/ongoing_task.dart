// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/config/colorconfig.dart';
import 'package:todos/homepage_widget/single_task.dart';
import 'package:todos/object/task.dart';
import 'package:todos/object/taskvault.dart';

class OngoingTask extends StatelessWidget {
  const OngoingTask({super.key,});

  @override
  Widget build(BuildContext context) {
    List<Task> onGoingTasks = Provider.of<TaskVault>(context).onGoingTasks;
    List<Widget> onGoingList = [];
    for (int i = 0; i < onGoingTasks.length; i++) {
      onGoingList.add(SingleTask(
        task: onGoingTasks[i],
      ));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 1),
                child: Text(
                  "Ongoing Task",
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
                  "${onGoingList.length} Tasks",
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
              children: content(onGoingList),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> content(List<Widget> onGoingList) {
    if(onGoingList.isEmpty){
      return [
        Container(
        height: 100,
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "There is no on going task!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cLightPurple,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Great job at completing it all :)",
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
      )];
    }

    return onGoingList;
  }
}
