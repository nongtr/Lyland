import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lyland/constants.dart';

class UpdateDocumentWidget extends StatefulWidget {
  final String collectionName;
  final String documentId;

  UpdateDocumentWidget(
      {required this.collectionName, required this.documentId});

  @override
  _UpdateDocumentWidgetState createState() => _UpdateDocumentWidgetState();
}

class _UpdateDocumentWidgetState extends State<UpdateDocumentWidget> {
  final FirebaseStorage _storageImageDB = FirebaseStorage.instance;
  XFile? beforeImageConverted;
  File? newImage;
  final picker = ImagePicker();

  ////////////////////
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _backgroundController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  List<String> _cityList = ['', 'بنغازي', 'طرابلس'];
  String? _selectedCity = '';
  List<String> _benghaziAreaList = ['', 'قنفوذة', 'طبالينو', 'الحدائق'];
  List<String> _tripoliAreaList = [
    ' جنزور',
    'تاجوراء',
    ' عين زارة',
  ];
  String? _selectedArea = '';
  List<String> getSelectedCityAreaList() {
    if (_selectedCity == 'بنغازي') {
      return _benghaziAreaList;
    } else if (_selectedCity == 'طرابلس') {
      return _tripoliAreaList;
    }
    return [];
  }

  String? selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'تعديل العقار ',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _titleController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "اسم العقار ",
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    textRadio('شقة', 'شقة'),
                    textRadio('استراحة', 'استراحة'),
                    textRadio('شاليه', 'شاليه'),
                  ],
                ),
                SizedBox(height: 20.0),
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
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42.0),
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
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 65.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45,
                        ),
                        Container(
                          width: 80,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _priceController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        Text(
                          ':السعر',
                          style: kTitleTextStyle,
                        ),
                      ],
                    ),
                  ),
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
                                    ? (_backgroundController.text
                                                .startsWith('http')
                                            ? NetworkImage(
                                                _backgroundController.text)
                                            : AssetImage(
                                                _backgroundController.text))
                                        as ImageProvider<Object>
                                    : FileImage(
                                        File(beforeImageConverted!.path)),
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
                SizedBox(height: 20.0),
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
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ".وصف العقار",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
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
                    onPressed: () {
                      _updateDocument();
                      Navigator.of(context)
                          .pushReplacementNamed('POwnerScreen');
                      setState(() {});
                    },
                    child: Text(
                      'حفظ',
                      style: kTitleTextStyle,
                    )),
              ],
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();

    // Fetch the current document values and initialize the text controllers
    FirebaseFirestore.instance
        .collection(widget.collectionName)
        .doc(widget.documentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _titleController.text = documentSnapshot.get('propertyName');
        _priceController.text = documentSnapshot.get('price').toString();
        _typeController.text = documentSnapshot.get('propertyType');
        setState(() {
          _selectedCity = documentSnapshot.get('city');
          _selectedArea = documentSnapshot.get('addressInCity');
          print(
              _selectedArea); // Assuming the field name in Firestore is 'city'
        });
        final imageURL = documentSnapshot.get('imageURL');
        if (imageURL != null && imageURL.isNotEmpty) {
          setState(() {
            _backgroundController.text = imageURL;
          });
        }

        _descriptionController.text = documentSnapshot.get('description');
      }
    });
  }

  void _updateDocument() async {
    try {
      if (newImage != null) {
        // Upload the new image to Firebase Storage
        final storageImage = await _storageImageDB
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}')
            .putFile(File(newImage!.path));

        // Get the download URL of the uploaded image
        final imageUrl = await storageImage.ref.getDownloadURL();

        // Update the document with the new image URL
        final documentRef = FirebaseFirestore.instance
            .collection(widget.collectionName)
            .doc(widget.documentId);

        await documentRef.update({
          'imageURL': imageUrl,
        });

        print('Document updated successfully');
        Navigator.pop(context, true);
      } else {
        print('No new image selected');
      }

      final DocumentReference documentRef = FirebaseFirestore.instance
          .collection(widget.collectionName)
          .doc(widget.documentId);

      await documentRef.update({
        'propertyName': _titleController.text,
        'price': double.parse(_priceController.text),
        'description': _descriptionController.text,
        'propertyType': _typeController.text,
        'city': _selectedCity,
        'addressInCity': _selectedArea
      });

      print('Document updated successfully');
      Navigator.pop(context, true);
    } catch (e) {
      print('Error updating document: $e');
    }
  }

////////////////////////
  Row textRadio(String title, String value) {
    return Row(
      children: [
        Radio(
            value: title,
            groupValue: _typeController.text,
            onChanged: (value) {
              setState(() {
                _typeController.text = value!;
              });
            }),
        Text(
          value,
          style: kTitleTextStyle,
        )
      ],
    );
  }

  ///////////////////
  Future<void> chooseImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        beforeImageConverted = XFile(pickedImage.path);
        newImage = File(pickedImage.path);
      });
    }
  }
}
