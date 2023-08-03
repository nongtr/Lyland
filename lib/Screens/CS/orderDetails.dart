import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class orderD extends StatefulWidget {
  final String documentId;
  orderD({required this.documentId});

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
    return Scaffold(
      body: Center(
          child: Text(
        orderD.status,
        style: TextStyle(fontSize: 25),
      )),
    );
  }
}
