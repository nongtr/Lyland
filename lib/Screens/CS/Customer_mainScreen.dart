import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lyland/Screens/CS/property_itemBody.dart';
import 'ProperItemShow.dart';
import 'Property_itemDetails.dart';
import 'property_itemBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: bColumn(index),
    );
  }

  Column bColumn(int index) {
    return Column(
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
        if (idPropertyPost.isNotEmpty)
          propertyPageBody(
            collectionName: 'posts',
          ),
        // هذا عبارة عن صف يعرض العقارات بالشكل عمودي
      ],
      //////
    );
  }
}
