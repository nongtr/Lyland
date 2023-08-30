import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/Property_itemDetails.dart';
import 'package:lyland/Screens/CS/orderDetails.dart';
import 'Property_itemDetails.dart';

class CScheck extends StatefulWidget {
  @override
  _CScheckState createState() => _CScheckState();
}

class _CScheckState extends State<CScheck> {
  List<String> idPropertyPost = [];
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  int listLength = 0;
  bool check = true;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _propertyStream;
  List<Map<String, dynamic>> _propertyDataList = [];

  @override
  void initState() {
    super.initState();
    _propertyStream = FirebaseFirestore.instance
        .collection('orders')
        .where('useID', isEqualTo: userId)
        .snapshots();
    _getProperties();
  } ///////////////////////////

  void _getProperties() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('orders')
        .where('useID', isEqualTo: userId)
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

  void _deleteOrder(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(documentId)
          .delete();
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم حذف الطلب بنجاح'),
        ),
      );
    } catch (e) {
      // Handle any errors that occur during deletion
      print('Error deleting document: $e');
    }
  }

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
            return Center(
                child: Text(
                  'لا يوجد لديك اي حجوزات',
                  style: TextStyle(fontSize: 25),
                ));
          }

          // Get the data from all documents
          _propertyDataList =
              snapshot.data!.docs.map((doc) => doc.data()).toList();

          return ListView.builder(
            itemCount: _propertyDataList.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> propertyData = _propertyDataList[index];
              String documentId = idPropertyPost[index];

              return Container(
                  padding: EdgeInsets.only(top: 30),
                  height: 224,
                  color: Colors.red.withOpacity(0),
                  child: Stack(
                    children: [
                      Container(
                        width: size.width,
                        height: 120,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://catking.in/wp-content/uploads/2018/05/reservation.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 80, left: 10),
                              child: Text(propertyData['cState'],
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0, 0),
                                          color: Colors.black,
                                          blurRadius: 15.0,
                                        )
                                      ])),
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(propertyData['propertyName'],
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(0, 0),
                                          color: Colors.black,
                                          blurRadius: 20.0,
                                        )
                                      ])),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 100,
                            margin:
                            EdgeInsets.only(left: 10, right: 10, top: 60),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFFe8e8e8e8),
                                      offset: Offset(0, 5),
                                      blurRadius: 5.0),
                                  BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-5, 0))
                                ]),
                            child: Container(
                              padding:
                              EdgeInsets.only(left: 50, right: 50, top: 17),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(propertyData['lastDay'],
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(width: 15),
                                      Text(propertyData['firstDay'],
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => orderD(
                                                    documentId:
                                                    idPropertyPost[
                                                    index],
                                                    s: propertyData[
                                                    'status'],
                                                  )));
                                        },
                                        child: Text(
                                          '< التفاصيل',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _deleteOrder(documentId);
                                        },
                                        child: Text(
                                          'حذف',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            },
          );
        },
      ),
    );
  }
}