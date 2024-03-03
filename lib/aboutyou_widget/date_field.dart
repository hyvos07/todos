// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class DateField extends StatefulWidget {
  const DateField({super.key});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final _profileBox = Hive.box('profileBox');
  DateTime selectedDate = DateTime.now(); // Default value

  @override
  void initState() {
    super.initState();
    // Load the existing birthday
    selectedDate = _profileBox.get('birthdate', defaultValue: DateTime.now());
  }

  // Date picker widget
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _profileBox.put('birthdate', selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    // intl DateFormat
    String formattedDate = DateFormat('MMM d, yyyy').format(selectedDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 2),
          margin: const EdgeInsets.only(top: 35),
          child: const Text(
            "Birthday Date",
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
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0x285038BC),
                  width: 1,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Icon(
                    Icons.calendar_today,
                    color: Color(0xFF5038BC),
                    size: 25,
                  ),
                ),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(formattedDate),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
