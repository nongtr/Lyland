import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lyland/Screens/CS/property_itemBody.dart';
import 'ProperItemShow.dart';
import 'itemDetails.dart';
import 'property_itemBody.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(children: [
            Padding(
              padding: EdgeInsets.only(left: 30, top: 45),

              //رسالة الترجيب //////////
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Taha',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              ),
              ////////////////////////////////////////////////////
            ),

            //////////////////// صندوق البحث /////////////
            Positioned(
                child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(0, 0), blurRadius: 2)
                ],
                borderRadius: BorderRadius.circular(80),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.search,
                      size: 33,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "ابحث هنا",
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
              margin: EdgeInsets.only(top: 107, left: 20, right: 20),
              padding: EdgeInsets.only(left: 25),
            )),

            ///////////////////////////////////////////
          ]),
          SizedBox(
            height: 70,
          ),
          propertyPageBody(),

          // هذا عبارة عن صف يعرض العقارات بالشكل عمودي
        ],
        //////
      ),
    );
  }
}
