import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// TextField(
// controller: _priceController,
// ),
class UpdateDocumentWidget extends StatefulWidget {
  final String collectionName;
  final String documentId;

  UpdateDocumentWidget(
      {required this.collectionName, required this.documentId});

  @override
  _UpdateDocumentWidgetState createState() => _UpdateDocumentWidgetState();
}

class _UpdateDocumentWidgetState extends State<UpdateDocumentWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _backgroundController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Document'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Title:'),
            TextField(
              controller: _titleController,
            ),
            SizedBox(height: 16.0),
            Text('Price:'),
            TextField(
              controller: _priceController,
            ),
            SizedBox(height: 16.0),
            Text('Description:'),
            TextField(
              controller: _descriptionController,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _updateDocument();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
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
        _descriptionController.text = documentSnapshot.get('description');
      }
    });
  }

  void _updateDocument() async {
    try {
      final DocumentReference documentRef = FirebaseFirestore.instance
          .collection(widget.collectionName)
          .doc(widget.documentId);

      await documentRef.update({
        'propertyName': _titleController.text,
        'price': double.parse(_priceController.text),
        'description': _descriptionController.text,
      });

      print('Document updated successfully');
      Navigator.pop(context, true);
    } catch (e) {
      print('Error updating document: $e');
    }
  }
}
