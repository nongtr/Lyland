////////////////////////////////////////////////
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/PO/editProperty.dart';
import '../PO/add_proberty_screen.dart';
import 'add_proberty_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants.dart';

class PO_mainScreen extends StatefulWidget {
  @override
  State<PO_mainScreen> createState() => _PO_mainScreenState();
}

class _PO_mainScreenState extends State<PO_mainScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  List<String> idPropertyPost = [];
  List<String> background = [];
  List<String> propertyName = [];
  List<String> propertyType = [];
  List<String> city = [];
  List<String> location = [];
  List<String> price = [];
  List<String> description = [];
  int listLength = 0;
  int index = 0;
  bool check = true;
  void _getProperties() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('posts')
        .where('userID', whereIn: [user?.uid]).snapshots()) {
      listLength = snapshot.docs.length;
      for (var property in snapshot.docs) {
        idPropertyPost.add(property.reference.id);
        if (idPropertyPost != []) {
          check = true;
        } else if (idPropertyPost == []) {
          check = false;
        }
        background.add(property.get('imageURL'));
        propertyName.add(property.get('propertyName'));

        setState(() {});
      }
    }
  }

  Future<void> deleteDocument(
      String collectionName, String documentId, String userId) async {
    try {
      final DocumentReference documentRef =
          FirebaseFirestore.instance.collection(collectionName).doc(documentId);

      // Check if the document exists and the user ID matches
      final DocumentSnapshot documentSnapshot = await documentRef.get();
      if (documentSnapshot.exists && documentSnapshot.get('userID') == userId) {
        await documentRef.delete();
        print('Document deleted successfully');
      } else {
        print('Document not found or user ID does not match');
      }
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getProperties();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        onPressed: () {
          showModalBottomSheet(
              //هذي حتخلي الصفحة تكبر على حسب العناصر اللي فيها
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(40))),
              context: context,
              builder: (cotext) => addProberty(ueserId: user!.uid));
          // Navigator.of(context).pushReplacementNamed('addPropertyScreen');
        },
        child: addButton(),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('posts').doc().get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return check
                ? ListView.builder(
                    itemCount: idPropertyPost.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(top: 20),
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 411,
                              height: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                image: DecorationImage(
                                    image: NetworkImage(background[index]),
                                    fit: BoxFit.cover),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    print(propertyType);
                                  },
                                  child: Text(
                                    propertyName[index],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: Offset(0, 0),
                                            color: Colors.black,
                                            blurRadius: 14.0,
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                            EditDeleteButtons(index),
                          ],
                        ),
                      );
                    })
                : Column(
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'لا توجد عقارات ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  );
          }),
    );
  }

  Widget EditDeleteButtons(int index) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(0, 3), blurRadius: 4)
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(9), bottomRight: Radius.circular(9)),
        color: Colors.white,
      ),
      width: 411,
      height: 52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          content: Center(
                              heightFactor: 1,
                              child: Text('هل تريد حذف العقار؟',
                                  style: KEditDeleteTextStyle)),
                          actions: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('لا',
                                        style: KEditDeleteTextStyle)),
                                SizedBox(
                                  width: 20,
                                ),
                                TextButton(
                                    onPressed: () {
                                      final String userId = user!.uid;
                                      deleteDocument('posts',
                                          idPropertyPost[index], userId);
                                      Navigator.pop(context);
                                    },
                                    child: Text('نعم',
                                        style: KEditDeleteTextStyle))
                              ],
                            ),
                          ],
                        ));
              },
              child: Text('حذف', style: KEditDeleteTextStyle)),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateDocumentWidget(
                      collectionName: 'posts',
                      documentId: idPropertyPost[index],
                    ),
                  ),
                ).then((value) {
                  if (value == true) {
                    // Do something after the document has been updated
                  }
                });
                // Call the updateDocumentFields function with the relevant parameters
              },
              child: Text(
                'تعديل',
                style: KEditDeleteTextStyle,
              ))
        ],
      ),
    );
  }
}

class addButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.add,
      color: Colors.black,
      size: 37,
    );
  }
}
