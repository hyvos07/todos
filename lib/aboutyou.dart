import 'package:flutter/material.dart';

class AboutYouPage extends StatelessWidget {
  const AboutYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5038BC),
      appBar: AppBar(
        elevation: 12,
        backgroundColor: Colors.white.withOpacity(0.7),
        scrolledUnderElevation: 10,
        shadowColor: Colors.white.withOpacity(0.5),
        toolbarHeight: 55,
        centerTitle: true,
        title: Image.asset(
          'images/logo2.png',
          fit: BoxFit.contain,
          height: 44,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name: John Doe',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  'Age: 25',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  'Location: New York',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
