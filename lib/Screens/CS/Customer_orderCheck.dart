import 'package:flutter/material.dart';
import 'package:lyland/constants.dart';

class CScheck extends StatefulWidget {
  const CScheck({Key? key}) : super(key: key);

  @override
  State<CScheck> createState() => _CScheckState();
}

class _CScheckState extends State<CScheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 10),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 80,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'تم الرفض',
                      style: kTitleTextStyle,
                    ),
                  ),
                ),
                Container(
                  width: 270,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/1012111.jpg'),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Text(
                      'شاليه فاخر',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 390,
            height: 50,
            color: Colors.white,
            child: Row(children: [
              GestureDetector(child: Icon(Icons.arrow_back_ios_new)),
              Text(
                'التفاصيل',
                style: TextStyle(fontSize: 20),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
