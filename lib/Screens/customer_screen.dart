import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Customer_Screen extends StatefulWidget {
  const Customer_Screen({Key? key}) : super(key: key);

  @override
  State<Customer_Screen> createState() => _Customer_ScreenState();
}

class _Customer_ScreenState extends State<Customer_Screen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'you signed ',
              style: TextStyle(fontSize: 22
              ),
              ),
              Text(user.email!,
              style: TextStyle(fontSize: 22,
              ),
              ),
              MaterialButton(
                  onPressed: (){
                  FirebaseAuth.instance.signOut();
                  },
                color: Colors.amber.shade900,
                child: Text('Sign Out'),

                  ),
            ],
          ),

      ),
    );
  }
}
