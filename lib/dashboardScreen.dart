import 'package:flutter/material.dart';
import 'package:nea/Pages/HomePage.dart';
import 'package:nea/Pages/SettingsPage(),.dart';
import 'package:nea/Pages/LeaderBoard.dart';

class dashboardScreen extends StatefulWidget {
  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  List<Widget> pages = [
    StepTracker(),
    LeaderboardScreen(),
    SettingsPage(),
  ];

  int currentIndex=0;
  void onTap(int index){
    setState(() {
      currentIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard),label: 'Leaderboard'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label:'Settings'),
        ],
      ),
    );
  }
}
