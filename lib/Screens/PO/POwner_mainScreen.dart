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
              child: Icon(Icons.add),
              backgroundColor: Colors.orange,
            ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('the proberty owner posts'),
        ],
      ),
    );
  }
}
