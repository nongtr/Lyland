import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/PO/aceeptPage.dart';
import 'package:lyland/constants.dart';

import '../CS/orderDetails.dart';

class ordersList extends StatefulWidget {
  final String propertyName;
  final String onwerId;

  ordersList({
    required this.onwerId,
    required this.propertyName,
  });

  @override
  _ordersListState createState() => _ordersListState();
}

class _ordersListState extends State<ordersList> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  late Stream<QuerySnapshot> _ordersStream;
  List<Map<String, dynamic>> _propertyDataList = [];

  //////////////////////////////
  int listLength = 0;
  bool check = true;
  List<String> idPropertyPost = [];

  void _getProperties() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('orders')
        .where('ownerID', isEqualTo: widget.onwerId)
        .where('propertyName', isEqualTo: widget.propertyName)
        .snapshots()) {
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
    _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('propertyName', isEqualTo: widget.propertyName)
        .snapshots();
    _getProperties();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _ordersStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // Display an error message
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          // Display a loading indicator
          return CircularProgressIndicator();
        }

        final orders = snapshot.data!.docs;

        return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                widget.propertyName,
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final data = orders[index].data() as Map<String, dynamic>;
              var customerName = data['userName'];
              var firstday = data['firstDay'];
              var lastday = data['lastDay'];
              var owner = data['ownerID'];
              var property = data['propertyName'];
              var status = data['status'];
              var ordereasons = data['orderReasons'];

              return SizedBox(
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                      right: 50,
                      top: 70,
                      child: Container(
                        // هذا القالب الأساسي اللي فيه جواه قوالب فرعية
                        margin: EdgeInsets.only(right: 0, left: 0),
                        width: 321,
                        height: 100,
                        child: Column(
                          children: [
                            Container(
                              // هذي الحاوية عبارة عن قالب فرعي جوا قالب الأساسي شور موعد الحجز
                              height: 55,
                              width: double.infinity,
                              color: Colors.blue,
                              child: Center(
                                  child: Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    lastday,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                  Text(
                                    ' -  ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 21),
                                  ),
                                  Text(
                                    firstday,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                ],
                              )),
                            ),

                            /// accept and decline
                            Container(
                                //هذا قالب فرعي واحد ثاني جوا القالب الأساسي وفيه صفين فيهن استدعاء ynButton AKA yes,no button
                                height: 45,
                                width: double.infinity,
                                color: Colors.white,
                                child: SizedBox(
                                  height: 47,
                                  child: Container(
                                      margin: EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    //هذي حتخلي الصفحة تكبر على حسب العناصر اللي فيها

                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        50))),
                                                    context: context,
                                                    builder: (cotext) =>
                                                        acceptP(
                                                          documentId:
                                                              idPropertyPost[
                                                                  index],
                                                          ownerId: owner,
                                                          customerName:
                                                              customerName,
                                                          propertyName:
                                                              property,
                                                          s: status,
                                                          firstDay: firstday,
                                                          lastDay: lastday,
                                                          orderReeasons:
                                                              ordereasons,
                                                        ));
                                                print(idPropertyPost[index]);
                                              },
                                              child: Text(
                                                ' < التفاصيل',
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black),
                                              )),
                                        ],
                                      )),
                                )),
                          ],
                        ),
                      ),
                    ),

                    // هذا استدعاء orderUsername statelessWidege
                    Positioned(
                      top: 35,
                      left: 241,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: Colors.blue,
                        ),
                        height: 40,
                        width: 120,
                        margin: EdgeInsets.only(left: 0),
                        padding: EdgeInsets.all(0),
                        child: Center(
                            child: Text(
                          customerName,
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
