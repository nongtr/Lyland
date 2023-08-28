import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Property_itemDetails.dart';

class SearchResultScreen extends StatefulWidget {
  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  List<String> idPropertyPost = [];
  bool check = true;
  int listLength = 0;

  @override
  void initState() {
    super.initState();
    _getProperties();
  }

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

  void _performSearch(String query) {
    final CollectionReference postsRef =
    FirebaseFirestore.instance.collection('posts');

    postsRef
        .where('propertyName', isGreaterThanOrEqualTo: query)
        .get()
        .then((QuerySnapshot<Object?> snapshot) {
      setState(() {
        _searchResults = snapshot.docs
            .map<Map<String, dynamic>>((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) => _performSearch(value),
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> result = _searchResults[index];
          return GestureDetector(
            onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => item_Details(
                      documentId: idPropertyPost[index],
                    )));
          },
            child: ListTile(
              leading: Image.network(result['imageURL']),
              title: Text(result['propertyName']),
              subtitle: Text('\$${result['price']}'),
              // Add more widgets to display other relevant data
            ),
          );
        },
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  const DetailsScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(result['imageURL']),
            SizedBox(height: 16),
            Text(result['propertyName']),
            Text('\$${result['price']}'),
            // Add more widgets to display other details
          ],
        ),
      ),
    );
  }
}