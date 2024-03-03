// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // This help Hive to understand how to read and write Task objects
  Hive.registerAdapter(TaskAdapter()); 

  // Open the box
  var taskBox = await Hive.openBox('taskBox'); // For storing tasks
  var profileBox = await Hive.openBox('profileBox'); // For storing profile info

  runApp(
    // State management using Provider
    ChangeNotifierProvider(
      create: (context) => TaskVault(), // Initiate the Vault of the tasks
      child: MainApp(),
    ),
  );
}

// -- Main App -- //
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BasePage(),
    );
  }
}

// -- Base of the App Page (Bottom Navbar Holder) -- //
class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
   // Page index and controller
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
              // Change the page based on its index on pages list
              _pageIndexNow = index; 
            });
          },
        ),
        bottomNavigationBar: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // -- Bottom Navbar -- //
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
                        duration: Duration(milliseconds: 200), // 200 ms animate
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  items: const [
                    // -- Homepage Button -- //
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    // -- Profile Page Button -- //
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'About You',
                    ),
                  ],
                ),
              ),
            ),
            
            // -- Add task button -- //
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
