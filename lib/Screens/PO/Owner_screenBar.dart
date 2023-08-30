import 'package:cloud_firestore/cloud_firestore.dart';
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

List<String> idPropertyPost = [];
List<String> background = [];

List<String> propertyType = [];
List<String> city = [];
List<String> location = [];
List<String> price = [];
List<String> description = [];
int listLength = 0;
bool check = true;
int index = 0;

class _ProOwnerScState extends State<ProOwnerSc> {
  void _getProperties() async {
    await for (var snapshot
    in FirebaseFirestore.instance.collection('posts').snapshots()) {
      listLength = snapshot.docs.length;
      for (var property in snapshot.docs) {
        idPropertyPost.add(property.reference.id);

        if (idPropertyPost.isNotEmpty) {
          check = true;
        } else {
          check = false;
        }

        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getProperties();
  }

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
                  icon: Icon(Icons.account_box), label: 'الحساب')
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