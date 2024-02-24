// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class singleTask extends StatelessWidget {
  final String taskName;
  bool taskDone = false;
  singleTask({super.key, required this.taskName});

  @override
  Widget build(BuildContext context) {
    // Screen Size
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1.5,
              color: Color.fromARGB(40, 54, 49, 82)
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x05006EE9),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              taskName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4A4646),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0.10,
              ),
            ),
            SizedBox(
              width: 22,
              height: 22,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(
                          side: BorderSide(width: 2, color: Color(0xFF5038BC)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 3,
                    top: 3,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const ShapeDecoration(
                        color: Colors.white,
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
