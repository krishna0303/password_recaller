import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseDatabase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void create() async {
    print('KRISHNA IS SAHANI');
    firestore.collection('Notes').doc('testNote').set({
      'userId': '123',
      'Title': 'new note',
      'Content': 'dummy',
      'Date': '16 April 2021',
      'isImportant': 'true',
    }).then((value) {
      print('EXECUTED SUCCESSFULLY');
    }).catchError((dynamic err) {
      print('ERROR OCCURED');
    });
  }

  void update() async {
    try {
      firestore.collection('users').doc('testUser').update({
        'firstName': 'Alan',
      });
    } catch (e) {
      print(e);
    }
  }

  void read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await firestore.collection('users').doc('testUser').get();
      print(documentSnapshot.data());
    } catch (e) {
      print(e);
    }
  }

  void delete() async {
    try {
      firestore.collection('users').doc('testUser').delete();
    } catch (e) {
      print(e);
    }
  }
}
