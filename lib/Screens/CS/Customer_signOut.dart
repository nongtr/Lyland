import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CSout extends StatefulWidget {
  const CSout({Key? key}) : super(key: key);

  @override
  State<CSout> createState() => _CSoutState();
}

class _CSoutState extends State<CSout> {
  final user = FirebaseAuth.instance.currentUser as User?;

  Future<void> deleteAccount() async {
    try {
      // Delete user document from Firestore
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).delete();

      // Delete user from Firebase Authentication
      await user?.delete();

      // Navigate back to the login screen
      Navigator.pushNamed(context,'/');
    } catch (e) {
      print('Error deleting account: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200, // Adjust the width as needed
              child: ElevatedButton.icon(
                onPressed: deleteAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                icon: Icon(
                  Icons.delete,
                  size: 18,
                ),
                label: Text(
                  'حذف حسابك',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 200, // Adjust the width as needed
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    FirebaseAuth.instance.signOut();
                    Navigator.pop(context);
                  });
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                icon: Icon(
                  Icons.logout,
                  size: 18,
                ),
                label: Text('تسجيل خروج'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}