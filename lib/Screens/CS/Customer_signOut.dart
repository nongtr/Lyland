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
  String? userName;

  Future<void> deleteAccount() async {
    try {
      // Delete user document from Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .delete();

      // Delete user from Firebase Authentication
      await user?.delete();

      // Navigate back to the login screen
      Navigator.pushNamed(context, 'loginScreen');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم حذف حسابك بنجاح'),
        ),
      );
    } catch (e) {
      print('Error deleting account: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> getCurrentUserName() async {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get();
      if (docSnapshot.exists) {
        setState(() {
          userName = docSnapshot.data()!['name'];
        });
      }
    }

    getCurrentUserName();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 100,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              userName ?? '',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Container(
              width: 300, // Adjust the width as needed
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).popAndPushNamed('loginScreen');
                  });
                },
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                icon: Icon(
                  Icons.logout,
                  size: 18,
                ),
                label: Text('تسجيل خروج'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 300, // Adjust the width as needed
              child: TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('هل أنت متأكد؟'),
                        content: Text('سيتم حذف حسابك'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                              deleteAccount(); // Call the deleteAccount method
                            },
                            child: Text('نعم'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('لا'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                ),
                icon: Icon(
                  Icons.delete_rounded,
                  size: 18,
                ),
                label: Text('حذف الحساب'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
