import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart ' as path;
import 'dart:io';

class AddImage extends StatefulWidget {
  AddImage({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  // reference for firebase storage
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  final List<File> image = [];
  final picker = ImagePicker();
  AddImage() {
    this.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          itemCount: image.length + 1,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, index) {
            return index == 0
                ? Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            uploadFile();
                          },
                          icon: Icon(Icons.face_outlined)),
                      IconButton(
                          onPressed: () {
                            chooseImage();
                          },
                          icon: Icon(Icons.add_a_photo)),
                    ],
                  )
                : Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(image[index - 1]),
                            fit: BoxFit.cover)),
                  );
          }),
    );
  }

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

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURls');
  }
}
