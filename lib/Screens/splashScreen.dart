import 'package:flutter/material.dart';
import 'package:lyland/Screens/login_screen.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  navigateToHome()async{
    await Future.delayed(Duration(seconds: 3),(){});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return login_screen();
        },
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueAccent,

      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/splash Screen .jpg'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}