import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('hai'),
            ElevatedButton(
                onPressed: () {
                  deleteDocument('Users', 'test');
                },
                child: Text('data')),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////

// Delete a document
Future<void> deleteDocument(String collectionName, String documentName) async {
  String myDocumentId = 'sender id';
  String collectionName = 'messages';

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(collectionName);

// Define your JSON data
  Map<String, dynamic> jsonData = {
    'field1': 'value1',
    'field2': 42,
    'field3': ['element1', 'element2', 'element3'],
    'field4': {'subfield1': 'subvalue1', 'subfield2': 'subvalue2'}
  };

// Update the entire document with the JSON data
  DocumentReference documentReference = collectionReference.doc(myDocumentId);
  documentReference.update(jsonData);

  ///
}
