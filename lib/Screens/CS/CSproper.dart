import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ProperItemShow.dart';
import 'itemDetails.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 60),

                //رسالة الترجيب //////////
                child: Row(
                  children: [
                    Text(
                      'Welocme   ',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'Mr.',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      'gfgf',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
                ////////////////////////////////////////////////////
              ),
            ),

            //////////////////// صندوق البحث /////////////
            Positioned(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search",
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.search,
                      size: 33,
                    ),
                  )
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 130.0),
              padding: EdgeInsets.only(left: 25),
              height: 54,
            ))
            ///////////////////////////////////////////
          ]),

          // هذا عبارة عن صف يعرض العقارات بالشكل عمودي
          Column(
            //العيال هظما عبارة عن إستدعاء من ProperItemShow.dart
            children: [Propertyitem(), Propertyitem(), Propertyitem()],
          )
        ],
        //////
      ),
    );
  }
}
