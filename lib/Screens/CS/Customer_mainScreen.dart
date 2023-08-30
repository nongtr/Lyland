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