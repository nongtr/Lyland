import 'package:flutter/material.dart';

class Customer_Screen extends StatefulWidget {
  const Customer_Screen({Key? key}) : super(key: key);

  @override
  State<Customer_Screen> createState() => _Customer_ScreenState();
}

class _Customer_ScreenState extends State<Customer_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('you signed '),
    );
  }
}
