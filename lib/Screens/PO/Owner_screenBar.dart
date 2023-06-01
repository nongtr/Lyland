import 'package:flutter/material.dart';
import 'package:lyland/Screens/PO/Owner_mainScreen.dart';
import 'package:lyland/Screens/PO/Owner_orders.dart';
import 'package:lyland/constants.dart';
import '../CS/Customer_orderCheck.dart';
import '../CS/Customer_signOut.dart';
import '../CS/Customer_mainScreen.dart';

class ProOwnerSc extends StatefulWidget {
  const ProOwnerSc();
  @override
  State<ProOwnerSc> createState() => _ProOwnerScState();
}

class _ProOwnerScState extends State<ProOwnerSc> {
  List Pages = [PO_mainScreen(), PO_orders(), CSout()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Pages[_currentIndex],
        // body: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Container(
        //       color: Colors.white38,
        //       child: const Text(
        //         ' Here Will be the Properties that will be added by the Owner',
        //         style: TextStyle(fontSize: 15.0),
        //       ),
        //     ),
        //     FloatingActionButton(
        //       elevation: 10.0,
        //       onPressed: () {
        //         Navigator.of(context).pushReplacementNamed('addPropertyScreen');
        //       },
        //       child: Icon(Icons.add),
        //       backgroundColor: Colors.orange,
        //     ),
        //   ],
        // ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
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
          ),
        ));
  }
}
