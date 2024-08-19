// ignore_for_file: subtype_of_sealed_class
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//########## OURDATABASE (firebase database)##########
abstract class OurDatabase {
  static final db = FirebaseFirestore.instance;

  static final CollectionReference<Map<String, dynamic>>
      firestoreSwiboardUsersCollectionReference =
      db.collection('swiboard_users');

  static Future create(
      String collection, String document, Map<String, dynamic> data) async {
    await db.collection(collection).doc(document).set(data);
  }

  static Future<Map<String, dynamic>?> read(
      String collection, String document) async {
    final snapshot = await db.collection(collection).doc(document).get();
    return snapshot.data();
  }

  static Future update(
      String collection, String document, Map<String, dynamic> data) async {
    await db.collection(collection).doc(document).update(data);
  }

  static Future replace(
      String collection, String document, Map<String, dynamic> data) async {
    await db.collection(collection).doc(document).set(data);
  }

  static Future delete(String collection, String document) async {
    await db.collection(collection).doc(document).delete();
  }
}
//####################################################

//#########  firebase userdata STREAM PROVIDER ################
final firestoreUserDataProvider =
    StreamProviderFamily<DocumentSnapshot<Map<String, dynamic>>, User>(
        (ref, User thisuser) {
  Stream<DocumentSnapshot<Map<String, dynamic>>> thisstream = OurDatabase.db
      .collection('swiboard_users')
      .doc(thisuser.email)
      .snapshots();
  return thisstream;
});
//##########################################################################

//############## Add Device to divice list of user ################
