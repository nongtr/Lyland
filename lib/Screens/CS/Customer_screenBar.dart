import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/Customer_orderCheck.dart';
import 'package:lyland/Screens/CS/Customer_signOut.dart';
import 'package:lyland/Screens/CS/Customer_mainScreen.dart';

class Customer_Screen extends StatefulWidget {
  const Customer_Screen({Key? key}) : super(key: key);

  @override
  State<Customer_Screen> createState() => _Customer_ScreenState();
}

class _Customer_ScreenState extends State<Customer_Screen> {
  List Pages = [Body(), CScheck(), CSout()];
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
                icon: Icon(Icons.account_box), label: 'الحساب')
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
