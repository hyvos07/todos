// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todos/aboutyou.dart';
import 'package:todos/addtask.dart';
import 'package:todos/homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BasePage(),
    );
  }
}

// -- Base of the App Page -- //
class BasePage extends StatefulWidget {
  const BasePage({super.key});

  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
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
        bottomNavigationBar: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(24, 0, 0, 0),
                    blurRadius: 10,
                    offset: Offset(0, -1),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  currentIndex: _pageIndexNow,
                  selectedItemColor: Color(0xFF5038bc),
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  selectedIconTheme: IconThemeData(size: 40),
                  unselectedIconTheme: IconThemeData(size: 32),
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
            ),
            Positioned(
                child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTask(),
                ),
              ),
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  color: Color(0xFF5038bc),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(24, 0, 0, 0),
                      blurRadius: 10,
                      offset: Offset(0, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
