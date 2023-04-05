import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/CScheck.dart';
import 'package:lyland/Screens/CS/CSout.dart';
import 'package:lyland/Screens/CS/CSproper.dart';

class Customer_Screen extends StatefulWidget {
  const Customer_Screen({Key? key}) : super(key: key);

  @override
  State<Customer_Screen> createState() => _Customer_ScreenState();
}

class _Customer_ScreenState extends State<Customer_Screen> {
  List Pages = [CSproper(), CScheck(), CSout()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 17,
          unselectedFontSize: 15,
          iconSize: 30,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: 'العقارات'),
            BottomNavigationBarItem(
                icon: Icon(Icons.event_note_rounded), label: 'الحجوزات'),
            BottomNavigationBarItem(
                icon: Icon(Icons.exit_to_app), label: 'خروج')
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
