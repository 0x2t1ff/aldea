import 'package:aldea/models/quickstrike_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference =
      Firestore.instance.collection('users');
      
  final CollectionReference _postsCollectionReference =
      Firestore.instance.collection('posts');
  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      var userData = await _userCollectionReference
          .where('uid', isEqualTo: uid)
          .getDocuments();
      return userData.documents[0].data;
    } catch (e) {}
  }

  Future addPost(QuickStrikePost post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      return e.toString();
    }
  }

  Future getPostsOnceOff() async {
    try {
      var postDocumentSnapshot = await _postsCollectionReference.getDocuments();
      if (postDocumentSnapshot.documentChanges.isNotEmpty) {
        return postDocumentSnapshot.documents
            .map((snapshot) => QuickStrikePost.fromMap(snapshot.data))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      return e.toString();
    }
  }
}
