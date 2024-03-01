// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:todos/aboutyou.dart';
import 'package:todos/addtask.dart';
import 'package:todos/homepage.dart';
import 'package:todos/object/task.dart';
import 'package:todos/object/taskvault.dart';


void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  // Open the box
  var taskBox = await Hive.openBox('taskBox');
  var profileBox = await Hive.openBox('profileBox');

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskVault(),
      child: MainApp(),
    ),
  );
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
      debugShowCheckedModeBanner: false,
      home: const BasePage(),
    );
  }
}

// -- Base of the App Page -- //
class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _pageIndexNow = 0;
  final PageController _pageController = PageController();
  HomePage homePage = const HomePage();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      homePage,
      AboutYouPage(),
    ];

    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: pages,
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
                  unselectedIconTheme: IconThemeData(size: 40),
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
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xFF5038bc),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(24, 0, 0, 0),
                      blurRadius: 10,
                      offset: Offset(0, 1),
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  size: 36,
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
