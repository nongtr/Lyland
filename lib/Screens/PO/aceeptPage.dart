import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/orderDetails.dart';
import 'package:lyland/constants.dart';

class acceptP extends StatefulWidget {
  final String documentId;
  final String ownerId;
  final String customerName;
  final String propertyName;
  final String firstDay;
  final String lastDay;
  final String orderReeasons;
  final String s;

  acceptP({
    required this.documentId,
    required this.ownerId,
    required this.customerName,
    required this.propertyName,
    required this.s,
    required this.firstDay,
    required this.lastDay,
    required this.orderReeasons,
  });

  @override
  State<acceptP> createState() => _acceptPState();
}

class _acceptPState extends State<acceptP> {
  TextEditingController _reasonController = TextEditingController();
  String _reason = '';
  String documentID = '';
  String aOr = '';
  late final pName1;

  @override
  Widget build(BuildContext context) {
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

              final pCity = data['city'];
              final pPrice = data['price'].toString();
              final pName = data['propertyName'];
              final pNumber = data['phoneNumber'];

              Future<void> updateDocumentField(
                  String documentId,
                  String fieldName,
                  dynamic value,
                  String fieldName2,
                  dynamic value2) async {
                try {
                  await FirebaseFirestore.instance
                      .collection('orders')
                      .doc(documentId)
                      .update({fieldName: value, fieldName2: value2});
                } catch (e) {
                  print('Error updating document field: $e');
                }
              }

              return Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 150),
                    child: buildRow(': اسم المستأجر', widget.customerName),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 148.0),
                    child: buildRow(': اسم العقار', pName),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 148.0),
                    child: buildRow(': من تاريخ', widget.firstDay),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 148.0),
                    child: buildRow(': إلى تاريخ ', widget.lastDay),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 98.0),
                    child: buildRow(': تفاصيل الحجز', widget.orderReeasons),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: .0),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: SingleChildScrollView(
                                  child: Container(
                                    height: 200, // Adjust the height as needed
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'هل انت متأكد ؟',
                                          style: KEditDeleteTextStyle,
                                        ),
                                        SizedBox(height: 20),
                                        TextField(
                                          controller: _reasonController,
                                          onChanged: (value) {
                                            setState(() {
                                              _reason = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'سبب الرفض (اختياري)',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  Row(
                                    children: [
                                      SizedBox(width: 50),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'لا',
                                          style: KEditDeleteTextStyle,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      TextButton(
                                        onPressed: () {
                                          String rejectionMessage =
                                              'تم الرفض لأن العقار محجوز';
                                          if (_reason != null &&
                                              _reason.isNotEmpty) {
                                            rejectionMessage =
                                            ' - $_reason';
                                          }
                                          updateDocumentField(
                                            widget.documentId,
                                            'status',
                                            rejectionMessage,
                                            'cState',
                                            'تم الرفض',
                                          );
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'نعم',
                                          style: KEditDeleteTextStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text(
                            'رفض',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            updateDocumentField(
                              widget.documentId,
                              'status',
                              'يرجى التواصل مع المالك لإنهاء باقي الأجراءات على الرقم: $pNumber',
                              'cState',
                              'تم القبول',
                            );
                            Navigator.pop(context);
                          },
                          child: Text(
                            'قبول',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Row buildRow(String title, String type) {
    return Row(
      children: [
        Expanded(
          child: Text(
            type,
            style: TextStyle(fontSize: 25),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}