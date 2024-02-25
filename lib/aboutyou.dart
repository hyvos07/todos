import 'package:flutter/material.dart';
import 'package:todos/aboutyou_widget/email_field.dart';
import 'package:todos/aboutyou_widget/date_field.dart';
import 'package:todos/aboutyou_widget/avatar.dart';
import 'package:todos/aboutyou_widget/name_field.dart';
import 'package:todos/aboutyou_widget/major_field.dart';

class AboutYouPage extends StatefulWidget {
  const AboutYouPage({super.key});

  @override
  State<AboutYouPage> createState() => _AboutYouPageState();
}

class _AboutYouPageState extends State<AboutYouPage> {
  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF5038BC),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text(
          "My Profile",
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
                  height: hei - 210,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(45),
                      topLeft: Radius.circular(45),
                    ),
                    color: Color.fromARGB(253, 253, 253, 253),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 40),
                    child: Column(
                      children: [
                        const Avatar(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NameField(),
                            MajorField(),
                            const DateField(),
                            EmailField()
                          ],
                        )
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
