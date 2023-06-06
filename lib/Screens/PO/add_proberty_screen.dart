import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lyland/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'add_probertyImages.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart ' as path;

class addProberty extends StatefulWidget {
  const addProberty({Key? key}) : super(key: key);

  @override
  State<addProberty> createState() => _addProbertyState();
}

class _addProbertyState extends State<addProberty> {
  final _auth = FirebaseAuth.instance;

  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  late final List<File> _image;

  List<String> _cityList = ['بنغازي', 'طرابلس'];
  String? _selectedCity = 'بنغازي';
  List<String> _areaList = ['الكيش', 'الحدائق'];
  String? _selectedArea = 'الكيش';
  final _mainLableControler = TextEditingController();
  final _priceControler = TextEditingController();
  final _descriptionController = TextEditingController();
  int _probertyType = 1;

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white38,
          leading: IconButton(
              onPressed: () {},
              icon: Padding(
                padding: const EdgeInsets.only(left: 330.0),
                child: Icon(
                  Icons.home_filled,
                  size: 34,
                ),
              )),
          title: Padding(
            padding: const EdgeInsets.only(left: 58.0, top: 5),
            child: Text(
              'اضافة عقار جديد',
              style: kTitleTextStyle,
            ),
          ),
        ),
        backgroundColor: Colors.grey[500],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 20, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 90,
                ),
                // main lable text field
                titleName(mainLableControler: _mainLableControler),
                SizedBox(
                  height: 15.0,
                ),

                Text(
                  ':نوع العقار',
                  style: kTitleTextStyle,
                ),
                // row for radio buttons
                Row(
                  children: [
                    Radio(
                        value: 1,
                        groupValue: _probertyType,
                        onChanged: (value) {
                          setState(() {
                            _probertyType = value!;
                          });
                        }),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'شقة',
                      style: kTitleTextStyle,
                    ),
                    Radio(
                        value: 2,
                        groupValue: _probertyType,
                        onChanged: (value) {
                          setState(() {
                            _probertyType = value!;
                          });
                        }),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'استراحة',
                      style: kTitleTextStyle,
                    ),
                    Radio(
                        value: 3,
                        groupValue: _probertyType,
                        onChanged: (value) {
                          setState(() {
                            _probertyType = value!;
                          });
                        }),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'شاليه',
                      style: kTitleTextStyle,
                    )
                  ],
                ),

                //drop down menu for the city

                Text(
                  ':المدينة',
                  style: kTitleTextStyle,
                ),
                Container(
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 3,
                                style: BorderStyle.solid,
                                color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 103),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedCity,
                          items: _cityList
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: kTitleTextStyle,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (item) =>
                              setState(() => _selectedCity = item),
                        ),
                      ),
                    ),
                  ),
                ),

                // drop down menu for the area
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  ':المنطقة',
                  style: kTitleTextStyle,
                ),
                Container(
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 2,
                                style: BorderStyle.solid,
                                color: Colors.white),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 103),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedArea,
                          items: _areaList
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: kTitleTextStyle,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (item) =>
                              setState(() => _selectedArea = item),
                        ),
                      ),
                    ),
                  ),
                ),

                // text field for the price
                SizedBox(
                  height: 25.0,
                ),
                priceNumber(priceControler: _priceControler),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'يسمح لك بإضافة 6 صور ',
                      style: TextStyle(fontSize: 13, color: Colors.white60),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'صور للإعلان',
                      style: kTitleTextStyle,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0),
                    border: Border.all(width: 4, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  width: 380,
                  height: 220,
                  child: Row(
                    children: [
                      Column(
                        children: [],
                      ),
                      Expanded(
                        child: AddImage(),
                        flex: 2,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  ':وصف العقار ',
                  style: kTitleTextStyle,
                ),
                Container(
                  width: 370,
                  height: 111,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0),
                    border: Border.all(width: 4, color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            '                                                                 اكتب هنا  ',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
          child: BottomAppBar(
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      uploadFile2();

                      sendPostInfoToDataBase();

                      Navigator.of(context)
                          .pushReplacementNamed('POwnerScreen');
                    },
                    child: Text(
                      'Save',
                      style: kTitleTextStyle,
                    )),
                SizedBox(
                  width: 10.0,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed('POwnerScreen');
                    },
                    child: Text(
                      'cancel',
                      style: kTitleTextStyle,
                    )),
              ],
            ),
          ),
        ));
  }

  Future uploadFile2() async {
    for (var img in _image) {
      ref = firebase_storage.FirebaseStorage.instance
          // create reference for every image in image list
          .ref()
          .child('images/${path.basename(img.path)}');
      // then we gonna make that image have that reference
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
        });
      });
    }
  }

// data sender //
  sendPostInfoToDataBase() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference reference =
        FirebaseFirestore.instance.collection('posts');
    reference.doc(user!.uid).set({
      'mainLable': _mainLableControler.text,
      'city': _selectedCity,
      'price': _priceControler.text,
      'description': _descriptionController.text,
      'image': imageUrl
    });
  }
}

class priceNumber extends StatelessWidget {
  const priceNumber({
    Key? key,
    required TextEditingController priceControler,
  })  : _priceControler = priceControler,
        super(key: key);

  final TextEditingController _priceControler;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: TextField(
        controller: _priceControler,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'ادخل سعر الايجار لليلة الواحدة',
          label: Padding(
            padding: EdgeInsets.only(left: 92),
            child: Text(
              'السعر ',
              style: kTitleTextStyle,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3),
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }
}

// class ImageContainer extends StatelessWidget {
class titleName extends StatelessWidget {
  const titleName({
    Key? key,
    required TextEditingController mainLableControler,
  })  : _mainLableControler = mainLableControler,
        super(key: key);

  final TextEditingController _mainLableControler;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      child: TextField(
        controller: _mainLableControler,
        decoration: const InputDecoration(
          label: Padding(
            padding: EdgeInsets.only(left: 130),
            child: Text(
              'اسم العقار',
              style: TextStyle(fontSize: 30),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 4),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 4),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          border: InputBorder.none,
          hintText: 'ادخل العنوان الرئيسي',
        ),
      ),
    );
  }
}
