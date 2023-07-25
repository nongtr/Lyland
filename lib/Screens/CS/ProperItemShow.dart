// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:lyland/Screens/CS/Property_itemDetails.dart';
// import 'Property_itemDetails.dart';
//
// class propertyPageBodyReplica extends StatefulWidget {
//   @override
//   State<propertyPageBodyReplica> createState() =>
//       _propertyPageBodyReplicaState();
// }
//
// class _propertyPageBodyReplicaState extends State<propertyPageBodyReplica> {
//   List<String> idPropertyPost = [];
//   List<String> background = [];
//   List<String> propertyName = [];
//   List<String> propertyType = [];
//   List<String> city = [];
//   List<String> location = [];
//   List<String> price = [];
//   List<String> description = [];
//   int listLength = 0;
//   bool check = true;
//
//   void _getProperties() async {
//     await for (var snapshot
//         in FirebaseFirestore.instance.collection('posts').snapshots()) {
//       listLength = snapshot.docs.length;
//       for (var property in snapshot.docs) {
//         idPropertyPost.add(property.reference.id);
//
//         if (idPropertyPost != []) {
//           check = true;
//         } else if (idPropertyPost == []) {
//           check = false;
//         }
//         background.add(property.get('imageURL'));
//         background.add(property.get('imageURL'));
//         propertyName.add(property.get('propertyName'));
//         propertyType.add(property.get('propertyType'));
//         city.add(property.get('city'));
//         location.add(property.get('addressInCity'));
//         price.add(property.get('price'));
//         description.add(property.get('description'));
//         print(propertyName);
//         setState(() {});
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _getProperties();
//   }
//
//   //
//   PageController pageController = PageController(viewportFraction: 0.85);
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SizedBox(
//       height: size.height,
//       width: size.width,
//       child: Scaffold(
//         body: FutureBuilder<DocumentSnapshot>(
//             future: FirebaseFirestore.instance.collection('posts').doc().get(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return check
//                   ? SizedBox(
//                       child: ListView.builder(
//                           itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                           margin: EdgeInsets.only(bottom: 20),
//                           height: 320,
//                           color: Colors.red.withOpacity(0),
//                           child: PageView.builder(
//                               controller: pageController,
//                               itemCount: propertyName.length,
//                               itemBuilder: (context, postion) {
//                                 return buildPageItem(postion);
//                               }),
//                         );
//                       }),
//                     )
//                   : Column(
//                       children: [
//                         SizedBox(
//                           height: 10.0,
//                         ),
//                       ],
//                     );
//             }),
//       ),
//     );
//   }
//   //   return Column(
//   //     children: [
//   //       Container(
//   //           margin: EdgeInsets.only(bottom: 20),
//   //           height: 320,
//   //           color: Colors.red.withOpacity(0),
//   //           child: PageView.builder(
//   //               controller: pageController,
//   //               itemCount: 4,
//   //               itemBuilder: (context, postion) {
//   //                 return _buildPageItem(postion);
//   //               })),
//   //     ],
//   //   );
//   // }
//
//   Widget buildPageItem(int index) {
//     return Stack(children: [
//       Container(
//         height: 220,
//         margin: EdgeInsets.only(left: 10, right: 10),
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage(background[index]), fit: BoxFit.cover),
//             borderRadius: BorderRadius.circular(30),
//             color: Colors.blue),
//       ),
//       Align(
//         alignment: Alignment.bottomCenter,
//         child: GestureDetector(
//           // onTap: () {
//           //   Navigator.push(
//           //       context,
//           //       MaterialPageRoute(
//           //           builder: (context) => item_Details(
//           //                 documentId: idPropertyPost[index],
//           //               )));
//           // },
//           // child: Container(
//             height: 120,
//             margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                       color: Color(0xFFe8e8e8e8),
//                       offset: Offset(0, 5),
//                       blurRadius: 5.0),
//                   BoxShadow(color: Colors.white, offset: Offset(-5, 0))
//                 ]),
//             child: Container(
//               padding: EdgeInsets.only(left: 15, right: 15, top: 15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(propertyName[index], style: TextStyle(fontSize: 20)),
//                   SizedBox(height: 0),
//                   Row(
//                     children: [
//                       Wrap(
//                           children: List.generate(
//                               1,
//                               (index) => Icon(Icons.attach_money_sharp,
//                                   color: Colors.green))),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         'دينار',
//                         style: TextStyle(fontWeight: FontWeight.w100),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         price[index],
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.hotel_class_sharp),
//                       Text(propertyType[index]),
//                       SizedBox(width: 5),
//                       Icon(
//                         Icons.location_city,
//                         color: Colors.blueAccent,
//                       ),
//                       Text(city[index]),
//                       SizedBox(width: 5),
//                       Icon(
//                         Icons.location_pin,
//                         color: Colors.red,
//                       ),
//                       Text(location[index])
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ]);
//   }
// }
//
// //Sure! Here's an example of a stateful widget in Flutter that allows t
// // he user to place an order for a hotel associated with their name and
// // the date and length of their stay:
//
// // import 'package:flutter/material.dart';
// //
// // class HotelOrderForm extends StatefulWidget {
// //   @override
// //   _HotelOrderFormState createState() => _HotelOrderFormState();
// // }
// //
// // class _HotelOrderFormState extends State<HotelOrderForm> {
// //   final _formKey = GlobalKey<FormState>();
// //   String _name;
// //   DateTime _date;
// //   int _lengthOfStay;
// //
// //   void _submitForm() {
// //     if (_formKey.currentState.validate()) {
// //       _formKey.currentState.save();
// //       // save the order to a database or file
// //       // you can also display a confirmation message to the user here
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Form(
// //       key: _formKey,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           TextFormField(
// //             decoration: InputDecoration(labelText: 'Name'),
// //             validator: (value) {
// //               if (value.isEmpty) {
// //                 return 'Please enter your name';
// //               }
// //               return null;
// //             },
// //             onSaved: (value) {
// //               _name = value;
// //             },
// //           ),
// //           SizedBox(height: 20),
// //           TextFormField(
// //             decoration: InputDecoration(labelText: 'Date of Stay'),
// //             validator: (value) {
// //               if (value.isEmpty) {
// //                 return 'Please enter the date of your stay';
// //               }
// //               return null;
// //             },
// //             onSaved: (value) {
// //               _date = DateTime.parse(value);
// //             },
// //           ),
// //           SizedBox(height: 20),
// //           TextFormField(
// //             decoration: InputDecoration(labelText: 'Length of Stay'),
// //             keyboardType: TextInputType.number,
// //             validator: (value) {
// //               if (value.isEmpty) {
// //                 return 'Please enter the length of your stay';
// //               }
// //               if (int.tryParse(value) == null) {
// //                 return 'Please enter a valid number';
// //               }
// //               return null;
// //             },
// //             onSaved: (value) {
// //               _lengthOfStay = int.parse(value);
// //             },
// //           ),
// //           SizedBox(height: 20),
// //           RaisedButton(
// //             child: Text('Submit'),
// //             onPressed: _submitForm,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// // o use this widget in your app,
// // you can simply add it to the widget tree, like this:
//
// // import 'package:flutter/material.dart';
// // import 'hotel_order_form.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Hotel Order Form',
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Hotel Order Form'),
// //         ),
// //         body: Padding(
// //           padding: EdgeInsets.all(20),
// //           child: HotelOrderForm(),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// //his will display the hotel order form on the screen, and when the user submits
// // the form, the data will be saved to the _name, _date, and _lengthOfStay variables
// // in the stateful widget's _HotelOrderFormState class. You can then save this data
// // to a database or file, as shown in the submitForm() method.
//
// //s there a way to display a confirmation message after the user submits the form?
// //ANSWER :
// //Yes, you can display a confirmation message after the user submits the form. One
// // way to do this is by using a SnackBar widget in Flutter.
// // Here's an updated version of the _HotelOrderFormState class that displays a
// // confirmation message when the user submits the form:
//
// // class _HotelOrderFormState extends State<HotelOrderForm> {
// //   final _formKey = GlobalKey<FormState>();
// //   String _name;
// //   DateTime _date;
// //   int _lengthOfStay;
// //
// //   void _submitForm() {
// //     if (_formKey.currentState.validate()) {
// //       _formKey.currentState.save();
// //       // save the order to a database or file
// //
// //       // show a snackbar to confirm the order
// //       Scaffold.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Thank you for your order!'),
// //           duration: Duration(seconds: 3),
// //         ),
// //       );
// //
// //       // clear the form
// //       _formKey.currentState.reset();
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Form(
// //       key: _formKey,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           TextFormField(
// //             decoration: InputDecoration(labelText: 'Name'),
// //             validator: (value) {
// //               if (value.isEmpty) {
// //                 return 'Please enter your name';
// //               }
// //               return null;
// //             },
// //             onSaved: (value) {
// //               _name = value;
// //             },
// //           ),
// //           SizedBox(height: 20),
// //           TextFormField(
// //             decoration: InputDecoration(labelText: 'Date of Stay'),
// //             validator: (value) {
// //               if (value.isEmpty) {
// //                 return 'Please enter the date of your stay';
// //               }
// //               return null;
// //             },
// //             onSaved: (value) {
// //               _date = DateTime.parse(value);
// //             },
// //           ),
// //           SizedBox(height: 20),
// //           TextFormField(
// //             decoration: InputDecoration(labelText: 'Length of Stay'),
// //             keyboardType: TextInputType.number,
// //             validator: (value) {
// //               if (value.isEmpty) {
// //                 return 'Please enter the length of your stay';
// //               }
// //               if (int.tryParse(value) == null) {
// //                 return 'Please enter a valid number';
// //               }
// //               return null;
// //             },
// //             onSaved: (value) {
// //               _lengthOfStay = int.parse(value);
// //             },
// //           ),
// //           SizedBox(height: 20),
// //           RaisedButton(
// //             child: Text('Submit'),
// //             onPressed: _submitForm,
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
