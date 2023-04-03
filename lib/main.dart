import 'package:flutter/material.dart';
import 'package:lyland/Auth.dart';
import 'package:lyland/login_page.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: login_page(),

      // home: login_page(), ملاحظة لما تكمل ربط الفايير بيس غير الــ
    );
  }
}

//مشروع التخرج برعاية رمضان
//int start;
//aa1ds
//test comment from faraj
