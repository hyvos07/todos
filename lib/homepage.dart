// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_app/homepage_widget/ongoing_task.dart';

import 'homepage_widget/completed_task.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String goodWhat(DateTime date) {
    // Greeting User Chooser
    var hour = date.hour;
    if (hour < 12) {
      return ("Good Morning");
    } else if (hour < 18) {
      return ("Good Afternoon");
    } else {
      return ("Good Evening");
    }
  }

  String greet(String goodWhat) {
    // Motivational Support Chooser
    if (goodWhat == "Good Morning") {
      return "New adventures await you today!";
    } else if (goodWhat == "Good Afternoon") {
      return "Hope you're having a great day!";
    } else {
      return "Nice works for today!";
    }
  }

  String menhera(String goodWhat) {
    // Menhera-chan Chooser
    if (goodWhat == "Good Morning") {
      return "images/morningmenhera.png";
    } else if (goodWhat == "Good Afternoon") {
      return "images/menheracheer.png";
    } else {
      return "images/gnmenhera.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get Today's Date; Adding 7 hours to change default UTC timezone to GMT+7
    DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7));

    // Screen Size
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        backgroundColor: Colors.white.withOpacity(0.7),
        scrolledUnderElevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 55,
        centerTitle: true,
        title: Image.asset(
          'images/logo2.png',
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
                      padding:
                          const EdgeInsets.only(top: 40, right: 25, left: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // -- Greetings -- //
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${goodWhat(now)}, Daniel!",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                  height: 0.05,
                                ),
                              ),
                              // -- Motivational Support -- //
                              Padding(
                                padding: const EdgeInsets.only(top: 27),
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
}
