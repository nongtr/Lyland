import 'package:flutter/material.dart';

import '../../constants.dart';

class PO_mainScreen extends StatelessWidget {
  const PO_mainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('addPropertyScreen');
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 37,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome proberty owner ',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 21),
            ),
          ],
        ),
      ),
    );
  }
}
