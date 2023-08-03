import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/orderDetails.dart';

class acceptP extends StatefulWidget {
  final String documentId;
  final String ownerId;
  final String customerName;
  final String propertyName;

  acceptP({
    required this.documentId,
    required this.ownerId,
    required this.customerName,
    required this.propertyName,
  });

  @override
  State<acceptP> createState() => _acceptPState();
}

class _acceptPState extends State<acceptP> {
  String documentID = '';
  String aOr = '';
  late final pName1;

  @override
  Widget build(BuildContext context) {
    // void sendDataToBWidget(
    //     String propertyName, Function(dynamic) onDataReceived) {
    //   FirebaseFirestore.instance
    //       .collection('posts')
    //       .where('propertyName', isEqualTo: propertyName)
    //       .get()
    //       .then((querySnapshot) {
    //     if (querySnapshot.docs.isNotEmpty) {
    //       onDataReceived(querySnapshot.docs[0].data());
    //     }
    //   });
    // }
///////////////////////////////////

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('propertyName', isEqualTo: widget.propertyName)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final properties = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              final data = properties[index].data() as Map<String, dynamic>;
              final pType = data['propertyType'];
              final pCity = data['city'];
              final pAdress = data['addressInCity'];
              final pPrice = data['price'].toString();
              final pName = data['propertyName'];
              ////////////////////
              void sendFieldsToWidgetB() {
                // Replace with your logic to retrieve the document fields based on documentID
                // For demonstration purposes, let's assume the values are hardcoded

                aOr = 'تم القبولل';
                print(widget.documentId);

                // Call the callback function in Widget B to update the fields
                orderD.updateFields(widget.documentId, aOr);
              }

              return Column(
                children: [
                  Text(
                    widget.customerName,
                    style: TextStyle(fontSize: 35),
                  ),
                  Text(
                    widget.propertyName,
                    style: TextStyle(fontSize: 35),
                  ),
                  Column(
                    children: [
                      Text(
                        pType,
                        style: TextStyle(fontSize: 35),
                      ),
                      Text(
                        pCity,
                        style: TextStyle(fontSize: 35),
                      ),
                      Text(
                        pAdress,
                        style: TextStyle(fontSize: 35),
                      ),
                      Text(
                        pPrice,
                        style: TextStyle(fontSize: 35),
                      ),
                      Text(
                        widget.documentId,
                        style: TextStyle(fontSize: 35),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      sendFieldsToWidgetB();
                    },
                    child: Text('Send Data to B Widget'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
