// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos/homepage_widget/ongoing_task.dart';
import 'package:todos/homepage_widget/completed_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _profileBox = Hive.box('profileBox');

  String wrapperText(String text) {
    if(text.length > 7) {
      return "Master";
    } else {
      if (text.isEmpty) {
        return "Master";
      }
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get Today's Date; Adding 7 hours to change default UTC timezone to GMT+7
    DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7));
    String username = _profileBox.get(
      'name', defaultValue: "Master").split(" ")[0];
    username = wrapperText(username);

    return Scaffold(
      backgroundColor: const Color.fromARGB(253, 253, 253, 253),
      appBar: AppBar(
        elevation: 12,
        backgroundColor: Colors.white.withOpacity(0.7),
        scrolledUnderElevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 55,
        centerTitle: true,
        title: Image.asset(
          'images/logofull.png',
          fit: BoxFit.contain,
          height: 44,
        ),
      ),
      body: SafeArea(
        child: Container(
            alignment: Alignment.center,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -- Greeting User -- //
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 50, right: 25, left: 25, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // -- Greetings -- //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${goodWhat(now)}, $username!",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 0.05,
                                ),
                              ),
                              // -- Motivational Support -- //
                              Padding(
                                padding: const EdgeInsets.only(top: 28),
                                child: Text(
                                  greet(goodWhat(now)),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0.05,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // -- Menhera-chan -- //
                          Image.asset(
                            menhera(goodWhat(now)),
                            fit: BoxFit.contain,
                            height: 55,
                          ),
                        ],
                      ),
                    ),
                    // -- Ongoing Task -- //
                    const OngoingTask(),
                    // -- Completed Task -- //
                    const CompletedTask(),
                  ],
                )
              ],
            )),
      ),
    );
  }

  // Greeting User Chooser
  String goodWhat(DateTime date) {
    var hour = date.hour;
    if (hour < 12) {
      return ("Good Morning");
    } else if (hour < 18) {
      return ("Good Afternoon");
    } else {
      return ("Good Evening");
    }
  }

  // Motivational Support Chooser
  String greet(String goodWhat) {
    if (goodWhat == "Good Morning") {
      return "New adventures await you today!";
    } else if (goodWhat == "Good Afternoon") {
      return "Hope you're having a great day!";
    } else {
      return "Nice works for today!";
    }
  }

  // Menhera-chan Chooser
  String menhera(String goodWhat) {
    if (goodWhat == "Good Morning") {
      return "images/morningmenhera.png";
    } else if (goodWhat == "Good Afternoon") {
      return "images/menheracheer.png";
    } else {
      return "images/gnmenhera.png";
    }
  }
}
