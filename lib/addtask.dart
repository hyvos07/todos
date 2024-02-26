import 'package:flutter/material.dart';
import 'package:todos/addtask_widget/deadline.dart';
import 'package:todos/addtask_widget/description.dart';
import 'package:todos/addtask_widget/title.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Stack(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                "Add Task",
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
              top: 50,
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
              )
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: hei - 150,
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
                        DescField(),
                        const DeadlineField(),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
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
                                  "Add Task",
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
}
