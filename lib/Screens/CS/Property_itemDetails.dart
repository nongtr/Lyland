import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lyland/Screens/CS/Customer_OrderDate.dart';
import 'package:lyland/Screens/PO/add_probertyContainers.dart';
import 'package:lyland/Widget/extandable_discription.dart';

class item_Details extends StatefulWidget {
  final String documentId;

  item_Details({required this.documentId});

  @override
  _item_DetailsState createState() => _item_DetailsState();
}

class _item_DetailsState extends State<item_Details> {
  late Stream<DocumentSnapshot> _documentStream;

  @override
  void initState() {
    super.initState();
    _documentStream = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.documentId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _documentStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        var documentData = snapshot.data!.data() as Map<String, dynamic>;
        var titleName = documentData['propertyName'];
        var propertyType = documentData['propertyType'];
        var image = documentData['imageURL'];
        var city = documentData['city'];
        var address = documentData['addressInCity'];
        var price = documentData['price'];
        var description = documentData['description'];

        // use specificData to display your widget
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 320,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover)),
                ),
              ),
              Positioned(
                top: 24,
                right: 360,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 45,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 0),
                        blurRadius: 7)
                  ],
                ),
              ),
              Positioned(
                  top: 250,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          height: 450,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              appColumn(titleName, city, propertyType, address),
                              SizedBox(
                                height: 20,
                              ),
                              Text('الصور', style: TextStyle(fontSize: 25)),
                              Row(
                                children: [
                                  miniPhotos(image),
                                  miniPhotos(image),
                                  miniPhotos(image),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('الوصف', style: TextStyle(fontSize: 25)),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: extendoo(textD: description!),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          bottomNavigationBar: Container(
            height: 100,
            padding: EdgeInsets.only(top: 30, bottom: 30, right: 20, left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.grey[200],
            ),
            child: Row(
              children: [
                Container(
                  width: 180,
                  height: 40,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 14.0,
                        left: 34,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'لليلة',
                            style: TextStyle(fontSize: 30),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'د',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text(
                            price.toString(),
                            style: TextStyle(fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40))),
                        context: context,
                        builder: (context) => coDate());
                  },
                  child: Container(
                    height: 100,
                    width: 150,
                    padding: EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        'طلب الحجز',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container miniPhotos(String image) {
    return Container(
      margin: EdgeInsets.all(4),
      height: 80,
      width: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Image(image: NetworkImage(image)),
      ),
    );
  }

  @override
  Widget appColumn(
      String titleName, String city, String type, String location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(titleName, style: TextStyle(fontSize: 20)),
        SizedBox(height: 0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Wrap(
                children: List.generate(
                    5, (index) => Icon(Icons.star, color: Colors.greenAccent))),
            SizedBox(
              width: 10,
            ),
            Text('4.5'),
            SizedBox(
              width: 10,
            ),
            Text('تقييم')
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.circle),
            Text(type),
            SizedBox(width: 5),
            Icon(Icons.location_city),
            Text(city),
            SizedBox(width: 5),
            Icon(Icons.location_pin),
            Text(location)
          ],
        )
      ],
    );
  }
}

////////////////////////////////////////////////////////////////
// هذا عبارة عن ويدجت مستقلة تحط في وصف العقار

////////////////////////////////////////////////////
// هذا عبارة عن ويدجيت مستقلة اللي منها درت و حطيت الصور الجانبية على شكل قالب
