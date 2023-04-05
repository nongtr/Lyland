import 'package:flutter/material.dart';
import 'package:lyland/constants.dart';
import 'CS/CScheck.dart';
import 'CS/CSout.dart';
import 'CS/CSproper.dart';

// object of the class constants to reach the variables
constants con = constants();

class ProOwnerSc extends StatefulWidget {
  @override
  State<ProOwnerSc> createState() => _ProOwnerScState();
}

class _ProOwnerScState extends State<ProOwnerSc> {
  List Pages = [CSproper(), CScheck(), CSout()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: Text(
            'LyLand',
            style: con.kTitleTextStyle,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
              backgroundColor: Colors.orange,
            ),
            Container(
              color: Colors.white38,
              child: const Text(
                ' Here Will be the Properties that will be added by the Owner',
                style: TextStyle(fontSize: 50.0),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 17,
          unselectedFontSize: 15,
          iconSize: 30,
          currentIndex: _currentIndex,
          items: const [
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
