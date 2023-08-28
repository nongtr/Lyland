import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lyland/Screens/PO/Owner_ordersList.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/Property_itemDetails.dart';
import 'package:lyland/Screens/CS/orderDetails.dart';

class PO_orders extends StatefulWidget {
  @override
  _PO_ordersState createState() => _PO_ordersState();
}

class _PO_ordersState extends State<PO_orders> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  late Stream<QuerySnapshot<Map<String, dynamic>>> _propertyStream;
  List<Map<String, dynamic>> _propertyDataList = [];

  ///////////////////////////
  @override
  void initState() {
    super.initState();
    _propertyStream = FirebaseFirestore.instance
        .collection('posts')
        .where('userID', isEqualTo: userId)
        .snapshots();
  } ///////////////////////////

  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _propertyStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No documents found.');
          }

          // Get the data from all documents
          _propertyDataList =
              snapshot.data!.docs.map((doc) => doc.data()).toList();

          return ListView.builder(
            itemCount: _propertyDataList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> propertyData = _propertyDataList[index];
              final properties = snapshot.data?.docs ?? [];

              final data = properties[index].data() as Map<String, dynamic>;

              final propertyName = data['propertyName'] as String;
              final background = data['imageURL'] as String;

              return Container(
                margin:
                    EdgeInsets.only(bottom: 0, right: 10, left: 10, top: 38),
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                      image: NetworkImage(background), fit: BoxFit.cover),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ordersList(
                                  ownerId: userId,
                                  propertyName: propertyName,
                                )));
                  },
                  child: Text(
                    propertyData['propertyName'],
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 0),
                            color: Colors.black,
                            blurRadius: 20.0,
                          )
                        ]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
