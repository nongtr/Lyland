import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class orderD extends StatefulWidget {
  final String documentId;
  final String s;
  orderD({required this.documentId, required this.s});

  @override
  _orderDState createState() => _orderDState();

  static String status = 'يرجى الإتصال بي المالك ';

  static updateFields(String dd, String xstatus) {
    status = xstatus;
  }
}

class _orderDState extends State<orderD> {
  //////

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.documentId)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data?.data() as Map<String, dynamic>?;
        final fieldValue = data?['status'];

        return Scaffold(
            body: Center(
                child: Text(
          ' $fieldValue',
          overflow: TextOverflow.visible,
          style: TextStyle(fontSize: 25),
        )));
      },
    );
  }
}
