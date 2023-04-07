import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CSout extends StatefulWidget {
  const CSout({Key? key}) : super(key: key);

  @override
  State<CSout> createState() => _CSoutState();
}

class _CSoutState extends State<CSout> {
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
              style: TextStyle(fontSize: 22),
            ),
            Text(
              user.email!,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  FirebaseAuth.instance.signOut();
                });
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
