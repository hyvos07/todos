// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/config/colorconfig.dart';
import 'package:todos/edit_task.dart';
import 'package:todos/object/task.dart';
import 'package:todos/object/taskvault.dart';

class SingleTask extends StatelessWidget {
  final Task task;

  const SingleTask({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    // Get the task details
    final String? taskID = task.id;
    final String? taskName = task.taskTitle;
    final bool taskDone = task.taskDone;

    // Task done ==> more greyish color
    Color textClr = taskDone
        ? const Color.fromARGB(255, 133, 133, 133)
        : const Color.fromARGB(255, 37, 37, 37);

    return GestureDetector(
      // Long press the task tile ==> edit the task
      onLongPress: () {
        var taskVault = Provider.of<TaskVault>(context, listen: false);
        // Get the corresponding task
        Task soonEditedTask = taskVault.getTaskById(taskID!);
        Navigator.push(
          context,
          // Let the tasks object passed to the edit task page
          MaterialPageRoute(
            builder: (context) => EditTask(task: soonEditedTask),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1.5, color: Color.fromARGB(40, 54, 49, 82)),
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x05006EE9),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: ListTile(
            visualDensity: VisualDensity.comfortable, // Bigger ListTile
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            // Check button
            leading: TextButton(
              onPressed: () {
                var taskVault = Provider.of<TaskVault>(context, listen: false);
                taskVault.onChanged(task);
              },
              child: Icon(
                // Task done ==> check box, else ==> empty check box
                taskDone ? Icons.check_box : Icons.check_box_outline_blank,
                color: cPurple,
                size: 30,
              ),
            ),
            title: Text(
              wrapperText(taskName!),
              textAlign: TextAlign.start,
              style: TextStyle(
                // Text color decided on the declaration of the variable above
                color: textClr,
                // Task done ==> line through, else ==> normal
                decoration: taskDone ? TextDecoration.lineThrough : null,
                fontSize: 13,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0.10,
              ),
            ),
            // If the task is done, the subtitle will be null/empty
            subtitle: !taskDone ? Text(
              // Get the due date: "<due days> days" or just "Today"
              task.getDueDays(),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: task.getDueColor(),
                fontSize: 10,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w100,
                height: 0.10,
              ),
            ) : null,
            // Delete Button
            trailing: IconButton(
              onPressed: () {
                var taskVault = Provider.of<TaskVault>(context, listen: false);
                taskVault.onDeleted(taskID!);
              },
              icon: const Icon(
                Icons.delete,
                color: Color(0xFF5038BC),
                size: 30,
              ),
            )
          ),
        ),
      ),
    );
  }

  // Wrapper text for the task title
  String wrapperText(String text) {
    if(text.length > 20) {
      return "${text.substring(0, 20)}...";
    } else {
      return text;
    }
  }
}
