import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lyland/Auth.dart';
import 'package:lyland/Screens/login_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LyLand());
}

class LyLand extends StatelessWidget {
  const LyLand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Auth(),

      // home: login_page(), ملاحظة لما تكمل ربط الفايير بيس غير الــ
    );
  }
}

//مشروع التخرج برعاية رمضان
//int start;
//aa1ds
//test comment from faraj
