import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  DatabaseService();

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  Future updateUserData(
      String user, String sugars, String name, int strength) async {
    return await postsCollection.doc(user).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  DateTime testTime = DateTime.now();
  String testString = 'testContent';
  void test() {
    FirebaseFirestore.instance.collection('testCollection').doc('testDoc').set({
      'timeOfCreation': testTime,
      'testString': testString,
    });
  }

  /// Creates a user in the database
  static Future createUserInDatabase({required User user}) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc()
        .set({'something': 'something'});
  }

  Stream<QuerySnapshot> get posts {
    return postsCollection.snapshots();
  }
}

// FirebaseFirestore
// db = FirebaseFirestore.instance;