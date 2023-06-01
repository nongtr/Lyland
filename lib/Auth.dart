import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/login_screen.dart';
import 'package:lyland/Screens/PO/Owner_screenBar.dart';
import 'Screens/CS/Customer_screenBar.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          return login_screen();
        }),
      ),
    );
  }
}
