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
            title: Text(widget.propertyName),
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

              return SizedBox(
                height: 120,
                child: Row(
                  children: [
                    Container(
                      // هذا القالب الأساسي اللي فيه جواه قوالب فرعية
                      margin: EdgeInsets.only(right: 10, left: 20),
                      width: 275,
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
                                  firstday,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 21),
                                ),
                                Text(
                                  ' --  ',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 21),
                                ),
                                Text(
                                  lastday,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 21),
                                ),
                              ],
                            )),
                          ),
                          Container(
                              //هذا قالب فرعي واحد ثاني جوا القالب الأساسي وفيه صفين فيهن استدعاء ynButton AKA yes,no button
                              height: 45,
                              width: double.infinity,
                              color: Colors.white,
                              child: SizedBox(
                                height: 47,
                                child: Container(
                                    margin: EdgeInsets.only(left: 50),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        content: Center(
                                                            heightFactor: 1,
                                                            child: Text(
                                                                'هل انت متأكد ؟',
                                                                style:
                                                                    KEditDeleteTextStyle)),
                                                        actions: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 50,
                                                              ),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'لا',
                                                                      style:
                                                                          KEditDeleteTextStyle)),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {},
                                                                  child: Text(
                                                                      'نعم',
                                                                      style:
                                                                          KEditDeleteTextStyle))
                                                            ],
                                                          ),
                                                        ],
                                                      ));
                                            },
                                            child: Text(
                                              'رفض',
                                              style: TextStyle(fontSize: 22),
                                            )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  //هذي حتخلي الصفحة تكبر على حسب العناصر اللي فيها

                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      40))),
                                                  context: context,
                                                  builder: (cotext) => acceptP(
                                                        documentId:
                                                            idPropertyPost[
                                                                index],
                                                        ownerId: owner,
                                                        customerName:
                                                            customerName,
                                                        propertyName: property,
                                                      ));
                                              print(idPropertyPost[index]);
                                            },
                                            child: Text(
                                              'قبول',
                                              style: TextStyle(fontSize: 22),
                                            )),
                                      ],
                                    )),
                              )),
                        ],
                      ),
                    ),

                    // هذا استدعاء orderUsername statelessWidege
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: new Border.all(color: Colors.black, width: 2),
                      ),
                      height: 100,
                      width: 90,
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.all(20),
                      child: Center(
                          child: Text(
                        customerName,
                        style: TextStyle(fontSize: 18),
                      )),
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
