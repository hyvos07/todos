// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

  String greet(String goodWhat) {
    if (goodWhat == "Good Morning") {
      return "New adventures await you today!";
    } else if (goodWhat == "Good Afternoon") {
      return "Hope you're having a great day!";
    } else {
      return "Nice works for today!";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get Today's Date
    var formatter = DateFormat('EEEE, MMM d yyyy');
    // Adding 7 hours to change default UTC timezone to GMT+7
    DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7));
    String formattedDate = formatter.format(now);

    // Screen Size
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        backgroundColor: Colors.white.withOpacity(0.7),
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
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            'images/morningmenhera.png',
                            fit: BoxFit.contain,
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                    // -- Ongoing Task -- //
                    const Padding(
                        padding: EdgeInsets.only(left: 25, top: 55),
                        child: Text(
                          "Ongoing Task",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                            height: 0.05,
                          ),
                        )),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
