import 'package:flutter/material.dart';
import 'login_page.dart';

void main() => runApp(const Myapp());

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: login_page(),
    );
  }
}

//مشروع التخرج برعاية رمضان
//test comment from faraj
//second test comment from moad
