import 'package:flutter/material.dart';

class AboutYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: const Center(
        child: Column(
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
    );
  }
}
