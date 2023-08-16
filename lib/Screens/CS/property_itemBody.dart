import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lyland/Screens/CS/Property_itemDetails.dart';
import 'Property_itemDetails.dart';

class propertyPageBody extends StatefulWidget {
  final String collectionName;

  propertyPageBody({required this.collectionName});

  @override
  _propertyPageBodyState createState() => _propertyPageBodyState();
}

class _propertyPageBodyState extends State<propertyPageBody> {
  List<String> idPropertyPost = [];
  List<Map<String, dynamic>> _filteredPropertyDataList = [];

  int listLength = 0;
  bool check = true;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _propertyStream;
  List<Map<String, dynamic>> _propertyDataList = [];
  TextEditingController _searchControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    _propertyStream = FirebaseFirestore.instance
        .collection(widget.collectionName)
        .snapshots();
    _getProperties();
  } ///////////////////////////

  void _getProperties() async {
    await for (var snapshot
        in FirebaseFirestore.instance.collection('posts').snapshots()) {
      listLength = snapshot.docs.length;
      for (var property in snapshot.docs) {
        idPropertyPost.add(property.reference.id);

        if (idPropertyPost != []) {
          check = true;
        } else if (idPropertyPost == []) {
          check = false;
        }

        setState(() {});
      }
    }
  }

  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _propertyStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No documents found.');
          }
          int trueItemCount = _propertyDataList.length - 1;
          // Get the data from all documents
          _propertyDataList =
              snapshot.data!.docs.map((doc) => doc.data()).toList();

          return bContainer();
        },
      ),
    );
  }

  Column bContainer() {
    return Column(
      children: [
        ////////////// search bar
        Positioned(
            child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0, 0), blurRadius: 2)
            ],
            borderRadius: BorderRadius.circular(80),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.search,
                  size: 33,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextField(
                    controller: _searchControler,
                    decoration: InputDecoration(
                        hintText: "ابحث هنا",
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none),
                    onChanged: (value) {},
                  ),
                ),
              ),
            ],
          ),
          margin: EdgeInsets.only(top: 107, left: 20, right: 20),
          padding: EdgeInsets.only(left: 25),
        )),

        //////////////
        SizedBox(
          height: 65,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 320,
          color: Colors.red.withOpacity(0),
          child: PageView.builder(
              controller: pageController,
              itemCount: _propertyDataList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> propertyData = _propertyDataList[index];

                return Stack(
                  children: [
                    Container(
                      height: 220,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(propertyData['imageURL']),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.blue),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => item_Details(
                                        documentId: idPropertyPost[index],
                                      )));
                        },
                        child: Container(
                          height: 120,
                          margin:
                              EdgeInsets.only(left: 30, right: 30, bottom: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFFe8e8e8e8),
                                    offset: Offset(0, 5),
                                    blurRadius: 5.0),
                                BoxShadow(
                                    color: Colors.white, offset: Offset(-5, 0))
                              ]),
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(propertyData['propertyName'],
                                    style: TextStyle(fontSize: 20)),
                                SizedBox(height: 0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.hotel_class_sharp),
                                    Text(propertyData['propertyType']),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.location_city,
                                      color: Colors.blueAccent,
                                    ),
                                    Text(propertyData['city']),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.red,
                                    ),
                                    Text(propertyData['addressInCity'])
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'دينار',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      propertyData['price'].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ],
    );
  }
}
