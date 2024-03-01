import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NameField extends StatelessWidget {
  final _nameController = TextEditingController();

  NameField({super.key});

  @override
  Widget build(BuildContext context) {
    final _profileBox = Hive.box('profileBox');
    _nameController.text = _profileBox.get('name', defaultValue: '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 2),
          margin: const EdgeInsets.only(top: 40),
          child: const Text(
            "Name",
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
                  hintText: "Enter your name",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 94, 86, 132),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w100,
                  ),
                ),
                controller: _nameController,
                onChanged: (value) => _profileBox.put('name', value),
              ),
            )),
      ],
    );
  }
}
