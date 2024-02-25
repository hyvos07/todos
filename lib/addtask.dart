import 'package:flutter/material.dart';
import 'package:todos/adddtask_widget/deadline.dart';
import 'package:todos/adddtask_widget/description.dart';
import 'package:todos/adddtask_widget/title.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF5038BC),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        toolbarHeight: 100,
        centerTitle: true,
        title: const Text(
          "Add Task",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: hei - 120,
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
                        TitleField(),
                        const DeadlineField(),
                        DescField(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: wid - 20,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 17, vertical: 10),
                            margin: const EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0x285038BC),
                                  width: 1,
                                ),
                                color: const Color(0xFF5038BC),
                                borderRadius: BorderRadius.circular(12)),
                            child: const Text(
                              "Add Task",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
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
}
