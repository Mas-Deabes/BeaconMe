import 'package:flutter/material.dart';
import 'package:nea/Pages/HomePage.dart';
import 'package:nea/Pages/SettingsPage(),.dart';

class dashboardScreen extends StatefulWidget {
  @override
  State<dashboardScreen> createState() => _dashboardScreenState();
}

class _dashboardScreenState extends State<dashboardScreen> {
  List pages = [
    HomePage(),
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
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label:'Settings'),
        ],
      ),
    );
  }
}
