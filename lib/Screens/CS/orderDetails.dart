import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class orderD extends StatefulWidget {
  final String documentId;
  final String s;
  orderD({required this.documentId, required this.s});

  @override
  _orderDState createState() => _orderDState();
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
                child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              ' $fieldValue',
              style: TextStyle(fontSize: 24),
            ),
          ),
        )));
      },
    );
  }
}
