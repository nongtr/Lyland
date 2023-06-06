import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lyland/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'add_probertyContainers.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart ' as path;

class addProberty extends StatefulWidget {
  final String? ueserId;
  const addProberty({Key? key, this.ueserId}) : super(key: key);

  @override
  State<addProberty> createState() => _addProbertyState();
}

class _addProbertyState extends State<addProberty> {
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  final List<File> image = [];
  final picker = ImagePicker();

  final _auth = FirebaseAuth.instance;

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
                    color: Colors.white.withOpacity(1),
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
                          child: GridView.builder(
                              itemCount: image.length + 1,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4),
                              itemBuilder: (context, index) {
                                return index == 0
                                    ? IconButton(
                                        onPressed: () {
                                          chooseImage();
                                        },
                                        icon: Icon(Icons.add_a_photo))
                                    : Container(
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:
                                                    FileImage(image[index - 1]),
                                                fit: BoxFit.cover)),
                                      );
                              }))
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
                      sendPostInfoToDataBase();
                      uploadFile();
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

  //image functions
  Future chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image.add(File(pickedFile.path));
      }
    });
  }

  Future uploadFile() async {
    for (var img in image) {
      final postID = DateTime.now().microsecondsSinceEpoch.toString();
      ref = firebase_storage.FirebaseStorage.instance

          // CREATE REFERENCE FOR EVERY IMAGE in IMAGE LIST
          .ref()
          .child('${widget.ueserId}/images')
          .child('post_$postID');
      // Then WE GONNA MAKE THAT IMAGE HAVE THAT  REFERENCE
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imgRef.add({'url': value});
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURls');
  }
  ////////////////////////////////////

// DATA SENDER
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
