import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lyland/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'add_probertyContainers.dart';
import 'package:firebase_storage/firebase_storage.dart';

class addProberty extends StatefulWidget {
  final String? ueserId;
  const addProberty({Key? key, this.ueserId}) : super(key: key);

  @override
  State<addProberty> createState() => _addProbertyState();
}

class _addProbertyState extends State<addProberty> {
  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');
  final FirebaseStorage _storageImageDB = FirebaseStorage.instance;
  XFile? beforeImageConverted;
  File? newImage;
  final picker = ImagePicker();

  final _auth = FirebaseAuth.instance;

  List<String> _cityList = ['بنغازي', 'طرابلس'];
  String? _selectedCity = 'بنغازي';
  List<String> _areaList = ['الكيش', 'الحدائق'];
  String? _selectedArea = 'الكيش';
  final _mainLableControler = TextEditingController();
  final _priceControler = TextEditingController();
  final _descriptionController = TextEditingController();
  String? selectedType;

  // DATA SENDER
  sendPostInfoToDataBase() async {
    var storageImage =
        await _storageImageDB.ref().child('images').putFile(newImage!);
    var url = await storageImage.ref.getDownloadURL();
    var user = _auth.currentUser;
    _postsCollection.add({
      'userID': user?.uid,
      'propertyName': _mainLableControler.text,
      'propertyType': selectedType,
      'city': _selectedCity,
      'addressInCity': _selectedArea,
      'price': _priceControler.text,
      'description': _descriptionController.text,
      'imageURL': url
    });
  }

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
                Center(
                    child: titleName(mainLableControler: _mainLableControler)),
                SizedBox(
                  height: 15.0,
                ),

                Text(
                  ':نوع العقار',
                  style: kTitleTextStyle,
                ),
                // row for radio buttons
                RadioListTile(
                    title: Text(
                      'شقة',
                      style: kTitleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    value: 'شقة',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    }),

                RadioListTile(
                    title: Text(
                      'استراحة',
                      style: kTitleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    value: 'استراحة',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    }),

                RadioListTile(
                    title: Text(
                      'شاليه',
                      style: kTitleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    value: 'شاليه',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    }),

                //drop down menu for the city

                Text(
                  ':المدينة',
                  style: kTitleTextStyle,
                ),
                Center(
                  child: Container(
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
                            dropdownColor: Colors.black,
                            value: _selectedCity,
                            items: _cityList
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    alignment: Alignment.center,
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
                ),

                // drop down menu for the area
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  ':المنطقة',
                  style: kTitleTextStyle,
                ),
                Center(
                  child: Container(
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
                            dropdownColor: Colors.black,
                            value: _selectedArea,
                            items: _areaList
                                .map(
                                  (item) => DropdownMenuItem(
                                    value: item,
                                    alignment: Alignment.center,
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
                ),

                // text field for the price
                SizedBox(
                  height: 25.0,
                ),
                Center(
                    child:
                        addPropertyContainer(priceControler: _priceControler)),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: IconButton(
                    iconSize: 30.0,
                    onPressed: () {
                      chooseImage();
                    },
                    icon: Icon(Icons.add_a_photo),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: 500.0,
                  height: 200.0,
                  margin: EdgeInsets.only(left: 8.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: beforeImageConverted == null
                            ? NetworkImage('https://picsum.photos/200/300')
                            : Image.file(File(beforeImageConverted!.path))
                                .image,
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.rectangle),
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
                      maxLength: 650,
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        counter: Offstage(),
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
                      sendPostInfoToDataBase();
                      Navigator.of(context)
                          .pushReplacementNamed('POwnerScreen');
                      setState(() {});
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

  //image functions
  Future chooseImage() async {
    beforeImageConverted = await picker.pickImage(source: ImageSource.gallery);
    newImage = File(beforeImageConverted!.path);
    setState(() {});
  }
}
