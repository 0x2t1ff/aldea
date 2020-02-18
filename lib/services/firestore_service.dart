import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference =
      Firestore.instance.collection('users');

  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      var userData = await _userCollectionReference.where('uid', isEqualTo: uid).getDocuments();
      return userData.documents[0].data;
    } catch (e) {
    }
  } 
}
