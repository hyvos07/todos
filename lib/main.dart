// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'aboutyou.dart';
import 'homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _pageIndexNow = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    HomePage(),
    AboutYouPage(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _pages,
          onPageChanged: (int index) {
            setState(() {
              _pageIndexNow = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndexNow,
          onTap: (int index) {
            setState(() {
              _pageIndexNow = index;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'About You',
            ),
          ],
        ),
      ),
    );
  }
}
