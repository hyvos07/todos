import 'package:flutter/material.dart';
// Task title field

class TitleField extends StatelessWidget {
  final _titleController = TextEditingController();

  get titleController => _titleController;

  TitleField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 2),
          margin: const EdgeInsets.only(top: 33),
          child: const Text(
            "Title",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color.fromARGB(255, 71, 58, 128),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 0.05,
            ),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0x285038BC),
                  width: 1,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: TextField(
                decoration: const InputDecoration(
                  /*
                  There is no limitation on how long the task's name can be,
                  but there is a wrapper to resolve the overflow issue.
                  */
                  hintText: "Enter the task's name",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 94, 86, 132),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w100,
                  ),
                ),
                controller: _titleController,
              ),
            )),
      ],
    );
  }
}
