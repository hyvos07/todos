import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todos/addtask_widget/deadline.dart';
import 'package:todos/addtask_widget/description.dart';
import 'package:todos/addtask_widget/title.dart';
import 'package:todos/config/colorconfig.dart';
import 'package:todos/object/task.dart';
import 'package:todos/object/taskvault.dart';

class EditTask extends StatefulWidget {
  final Task task;
  const EditTask({super.key, required this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TitleField titleField = TitleField();
  DescField descField = DescField();
  DeadlineField deadlineField = DeadlineField();

  late TextEditingController titleController = TextEditingController();
  late TextEditingController descController = TextEditingController();
  late DateTime startDate = DateTime.now();
  late DateTime endDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    Task task = widget.task;

    titleController = titleField.titleController;
    titleController.text = task.taskTitle!;
    descController = descField.descController;
    descController.text = task.taskDescription!;
    startDate = task.startDate;
    deadlineField.setStartDate(task.startDate);
    endDate = task.endDate;
    deadlineField.setEndDate(task.endDate);
  }

  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF5038BC),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Stack(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                "Edit Task",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: Colors.transparent,
              toolbarHeight: 100,
              centerTitle: true,
            ),
            Positioned(
                left: 18,
                top: 55,
                child: IconButton(
                  splashColor: Colors.transparent,
                  splashRadius: 1,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: hei - 70,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(45),
                      topLeft: Radius.circular(45),
                    ),
                    color: Color.fromARGB(253, 253, 253, 253),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 22),
                          child: Text(
                            wrapperText(widget.task.taskTitle!),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: cPurple,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0.05,
                            ),
                          ),
                        ),
                        titleField,
                        descField,
                        deadlineField,
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                if (titleController.text.isEmpty ||
                                    titleController.text == "") {
                                  return _showWarningDialog(
                                      context, "Title field can\nnot be empty");
                                }
                                onEditingTask(
                                  titleController.text,
                                  descController.text,
                                  deadlineField.startDate,
                                  deadlineField.endDate
                                );
                                                    
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: wid - 20,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17, vertical: 12),
                                margin: const EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0x285038BC),
                                      width: 1,
                                    ),
                                    color: const Color(0xFF5038BC),
                                    borderRadius: BorderRadius.circular(12)),
                                child: const Text(
                                  "Edit Task",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onEditingTask(title, desc, start, end) {
    Task task = widget.task;

    task.taskTitle = title;
    task.taskDescription = desc;
    task.startDate = start;
    task.endDate = end;

    Provider.of<TaskVault>(context, listen: false).refreshTask();
  }

  String wrapperText(String text) {
    if(text.length > 25) {
      return "${text.substring(0, 25)}...";
    } else {
      return text;
    }
  }

  void _showWarningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Warning!',
            style: TextStyle(
              color: Color.fromARGB(255, 23, 18, 46),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'images/confusedmenhera.png',
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 23, 18, 46),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 229, 229, 229),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
