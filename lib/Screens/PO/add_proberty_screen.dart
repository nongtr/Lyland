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
  // دالة للتحقق من ان كل الحقول تم تعبئتها
  bool _isFormValid = false;
  void _validateForm() {
    setState(() {
      _isFormValid = _mainLableControler.text.isNotEmpty &&
          selectedType != null &&
          _selectedCity != null &&
          _selectedArea != null &&
          _priceControler.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty &&
          newImage != null;
    });
  }

  final CollectionReference _postsCollection =
      FirebaseFirestore.instance.collection('posts');
  final FirebaseStorage _storageImageDB = FirebaseStorage.instance;
  XFile? beforeImageConverted;
  File? newImage;
  final picker = ImagePicker();

  final _auth = FirebaseAuth.instance;

  List<String> _cityList = ['بنغازي', 'طرابلس'];
  String? _selectedCity = 'بنغازي';
  List<String> _benghaziAreaList = ['', 'الكيش', 'الحدائق'];
  List<String> _tripoliAreaList = ['بن غشير', 'الاندلس'];
  String? _selectedArea = '';
  List<String> getSelectedCityAreaList() {
    if (_selectedCity == 'بنغازي') {
      return _benghaziAreaList;
    } else if (_selectedCity == 'طرابلس') {
      return _tripoliAreaList;
    }
    return [];
  }

  final _mainLableControler = TextEditingController();
  final _priceControler = TextEditingController();
  final _descriptionController = TextEditingController();
  String? selectedType;

  // DATA SENDER
  sendPostInfoToDataBase() async {
    var storageImage = await _storageImageDB
        .ref()
        .child('images/' + DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(newImage!);
    var url = await storageImage.ref.getDownloadURL();
    var user = _auth.currentUser;
    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(widget.ueserId);
    final userData = await userDocRef.get();
// Access the document fields
    final String phoneNum = userData.get('phoneNumber');

    _postsCollection.add({
      'userID': user?.uid,
      'propertyName': _mainLableControler.text,
      'propertyType': selectedType,
      'city': _selectedCity,
      'addressInCity': _selectedArea,
      'price': _priceControler.text,
      'description': _descriptionController.text,
      'imageURL': url,
      'phoneNumber': phoneNum
    });
  }

  void _saveProperty() {
    sendPostInfoToDataBase();
    Navigator.of(context).pushReplacementNamed('POwnerScreen');
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إضافة عقار بنجاح'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _validateForm();
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30))),
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                'إضافة عقار  ',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  // main lable text field
                  Center(
                      child:
                          titleName(mainLableControler: _mainLableControler)),
                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    children: [
                      textRadio('شقة', 'شقة'),
                      textRadio('استراحة', 'استراحة'),
                      textRadio('شاليه', 'شاليه'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //drop down menu for the city

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 35,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                value: _selectedCity,

                                // Add the hintText here
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
                                onChanged: (item) => setState(() {
                                  _selectedCity = item;
                                  _selectedArea = null;
                                }),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              ':المدينة',
                              style: kTitleTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // drop down menu for the area
                  SizedBox(
                    height: 15.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 35,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: Colors.white,
                                value: _selectedArea,
                                items: getSelectedCityAreaList()
                                    .map(
                                      (item) => DropdownMenuItem(
                                        value: item,
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          item,
                                          style: kTitleTextStyle,
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (item) =>
                                    setState(() => _selectedArea = item),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              ':المنطقة',
                              style: kTitleTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // text field for the price
                  SizedBox(
                    height: 25.0,
                  ),
                  Center(
                      child: addPropertyContainer(
                          priceControler: _priceControler)),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      height: 100,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 160,
                          ),
                          Container(
                            width: 100,
                            height: 75.0,
                            margin: EdgeInsets.only(left: 8.0),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                  image: beforeImageConverted == null
                                      ? NetworkImage(
                                          'https://picsum.photos/200/300')
                                      : Image.file(
                                              File(beforeImageConverted!.path))
                                          .image,
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.rectangle),
                          ),
                          IconButton(
                            iconSize: 30.0,
                            onPressed: () {
                              chooseImage();
                            },
                            icon: Icon(Icons.add_a_photo),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _descriptionController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: ".وصف العقار",
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
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
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('POwnerScreen');
                      },
                      child: Text(
                        'إلغاء',
                        style: kTitleTextStyle,
                      )),
                  SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      onPressed:_isFormValid ? () => _saveProperty() : null,
                      child: Text(
                        'حفظ',
                        style: kTitleTextStyle,
                      )),
                ],
              ),
            ),
          )),
    );
  }

  Row textRadio(String title, String value) {
    return Row(
      children: [
        Radio(
            value: title,
            groupValue: selectedType,
            onChanged: (value) {
              setState(() {
                selectedType = value;
              });
            }),
        Text(
          value,
          style: kTitleTextStyle,
        )
      ],
    );
  }

  //image functions
  Future chooseImage() async {
    beforeImageConverted = await picker.pickImage(source: ImageSource.gallery);
    newImage = File(beforeImageConverted!.path);
    setState(() {});
  }
}
