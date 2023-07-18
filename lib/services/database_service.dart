import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/models/image_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  static FirebaseFirestore get ff => FirebaseFirestore.instance;
  static FirebaseStorage get fs => FirebaseStorage.instance;

  /// Returns donwload url
  static Future<String> uploadImageToFBStorage(String name, Uint8List bytes) async {
    final imagesRef = fs.ref().child('images');
    final fileRef = imagesRef.child(name);
    await fileRef.putData(bytes);
    return await fileRef.getDownloadURL();
  }

  // #region Firestore

  static Future getTestImage() async {
    return await FirebaseFirestore.instance
        .collection('images')
        .doc('2jVt6FKZvZHmX6M8yF2c')
        .get()
        .then((value) => value);
  }

  // #endregion

  // Future updateUserData(String user, String sugars, String name, int strength) async {
  //   return await postsCollection.doc(user).set({
  //     'sugars': sugars,
  //     'name': name,
  //     'strength': strength,
  //   });
  // }

  static Future<ImageModel> getImageFromDB(String name) async {
    var document = await ff.collection('images').doc(name).get();
    return ImageModel.fromList(name: name, list: (document.data() as Map)['bytes']);
  }

  static Future uploadImageToDB(ImageModel image) {
    return FirebaseFirestore.instance
        .collection('images')
        .doc(image.name)
        .set({'bytes': image.bytes});
  }

  static Future<List> fetchTest() async {
    DocumentSnapshot documentSnapshot =
        await ff.collection('images').doc('2jVt6FKZvZHmX6M8yF2c').get();
    var list = (documentSnapshot.data()! as Map)['imageBytes'];
    return list;
  }

  // DateTime testTime = DateTime.now();
  // String testString = 'testContent';
  // void test() {
  //   FirebaseFirestore.instance.collection('testCollection').doc('testDoc').set({
  //     'timeOfCreation': testTime,
  //     'testString': testString,
  //   });
  // }

  /// Creates a user in the database
  static Future createUserInDatabase({required User user}) {
    return FirebaseFirestore.instance.collection('posts').doc().set({'something': 'something'});
  }

  // Stream<QuerySnapshot> get posts {
  //   return postsCollection.snapshots();
  // }
}

// FirebaseFirestore
// db = FirebaseFirestore.instance;