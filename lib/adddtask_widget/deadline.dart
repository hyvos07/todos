// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeadlineField extends StatefulWidget {
  const DeadlineField({super.key});

  @override
  State<DeadlineField> createState() => _DeadlineFieldState();
}

class _DeadlineFieldState extends State<DeadlineField> {
  late DateTime now = DateTime.now();
  late DateTime _startDate = DateTime(now.year, now.month, now.day);
  late DateTime _endDate = DateTime(now.year, now.month, now.day);

  // Every Loop on App, The Dates will be updated
  YourClass() {
    _initializeDates();
  }

  void _initializeDates() {
    // Update and Initialize the Dates
    DateTime now = DateTime.now();
    _startDate = DateTime(now.year, now.month, now.day);
    _endDate = DateTime(now.year, now.month, now.day);
  }

  Future<void> _selectStart(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked.isAfter(_endDate)) {
      _showWarningDialog(context, "Start date can't be\nafter end date");
    } else if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEnd(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked.isBefore(_startDate)) {
      _showWarningDialog(context, "End date can't be\nbefore start date");
    } else if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String startDateFormat = DateFormat('MMM d, yyyy').format(_startDate);
    String endDateFormat = DateFormat('MMM d, yyyy').format(_endDate);

    DateTime nowDateDays = DateTime(now.year, now.month, now.day);

    DateTime endDateDays =
        DateTime(_endDate.year, _endDate.month, _endDate.day);

    Duration difference = endDateDays.difference(nowDateDays);
    String daysDifference = "${difference.inDays} days";

    String taskDue = "This task is due for:";
    Color taskDueColor = const Color(0xFF5038BC);

    if (difference.inDays == 0) {
      setState(() {
        daysDifference = "Today";
        taskDueColor = const Color(0xFF5038BC);
      });
    } else if (now.isBefore(_endDate)) {
      setState(() {
        daysDifference = "${difference.inDays} days";
        taskDueColor = const Color(0xFF5038BC);
      });
    } else if (daysDifference.substring(0, 1) == "-") {
      setState(() {
        daysDifference = daysDifference.substring(1);
        taskDue = "This task is already due for:";
        taskDueColor = const Color(0xFFD32F2F);
      });
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // -- Start Date -- //
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 2),
                  margin: const EdgeInsets.only(top: 40),
                  child: const Text(
                    "Start",
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
                  onTap: () => _selectStart(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                        const Icon(
                          Icons.calendar_today,
                          color: Color(0xFF5038BC),
                          size: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextButton(
                            onPressed: () => _selectStart(context),
                            child: Text(
                              startDateFormat,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 94, 86, 132),
                                fontSize: 14,
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
              ],
            ),
            // -- End Date -- //
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 2),
                  margin: const EdgeInsets.only(top: 40),
                  child: const Text(
                    "End",
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
                  onTap: () => _selectEnd(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                        const Icon(
                          Icons.calendar_today,
                          color: Color(0xFF5038BC),
                          size: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextButton(
                            onPressed: () => _selectEnd(context),
                            child: Text(
                              endDateFormat,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 94, 86, 132),
                                fontSize: 14,
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
              ],
            ),
          ],
        ),
        // -- Due Date -- //
        Padding(
          padding: const EdgeInsets.only(top: 23, bottom: 1),
          child: Text(
            taskDue,
            style: TextStyle(
              color: taskDueColor,
              fontSize: 17,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          daysDifference,
          style: TextStyle(
            color: taskDueColor,
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
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