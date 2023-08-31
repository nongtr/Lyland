import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lyland/Auth.dart';
import 'package:lyland/Screens/CS/Customer_screenBar.dart';
import 'package:lyland/Screens/PO/add_proberty_screen.dart';
import 'package:lyland/Screens/login_screen.dart';
import 'package:lyland/Screens/PO/Owner_screenBar.dart';
import 'package:lyland/Screens/signup_screen.dart';
import 'package:lyland/Screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LyLand());
}

class LyLand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => splash(),
        'loginScreen': (context) => login_screen(),
        'signUpScreen': (context) => const SignUpScreen(),
        'AuthScreen': (context) => const Auth(),
        'customerScreen': (context) => const Customer_Screen(),
        'POwnerScreen': (context) => const ProOwnerSc(),
        'addPropertyScreen': (context) => const addProberty(),
      },
    );
  }
}
