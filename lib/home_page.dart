import 'package:flutter/material.dart';

class home_page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.white38,
          child: Text(' Here Will be the home page',
            style:TextStyle(fontSize: 50.0) ,),
        )
      ],
    );
  }
}
