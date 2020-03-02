import 'dart:async';

import 'package:aldea/models/quickstrike_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../models/user_model.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference =
      Firestore.instance.collection('users');

  final CollectionReference _postsCollectionReference =
      Firestore.instance.collection('posts');

  final CollectionReference _communitiesCollectionReference =
      Firestore.instance.collection('communities');
  final CollectionReference _followingPostsCollectionReference =
      Firestore.instance.collection('followers');

  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      var userData = await _userCollectionReference.document(uid).get();
      return userData.data;
    } catch (e) {
      return e.message;
    }
  }

  Future addPost(QuickStrikePost post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      return e.toString();
    }
  }

  Future createUser(User user) async {
    try {
      await _userCollectionReference.document(user.uid).setData(user.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getPostsOnceOff(String eventId) async {
    try {
      var postDocumentSnapshot = await _postsCollectionReference
          .where("id", isEqualTo: eventId)
          .limit(10)
          .getDocuments();
      print(postDocumentSnapshot.documents.last.data.toString() +
          "printing length of documents" +
          eventId);
      {
        if (postDocumentSnapshot.documents.isNotEmpty) {
          return QuickStrikePost.fromMap(
              postDocumentSnapshot.documents.last.data);
        }
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future updateUser(
      {String uid,
      String picUrl,
      String bkdPicUrl,
      String picName,
      String bkdPicName,
      String email,
      String phoneNumber,
      String gender,
      String address}) async {
    await _userCollectionReference.document(uid).updateData({
      'picUrl': picUrl,
      'picName': picName,
      'bkdPicUrl': bkdPicUrl,
      'bkdPicName': bkdPicName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'address': address
    });
  }

  Future<List<DocumentSnapshot>> getCommunities({int skip}) async {
    try {
      var communitiesQuery = await _communitiesCollectionReference
          .orderBy("followerCount", descending: true)
          .limit(6)
          .getDocuments();
      return communitiesQuery.documents;
    } catch (e) {
      return e.message;
    }
  }

  Future<Map<String, dynamic>> getTopCommunities() async {
    try {
      var communitiesData =
          await _communitiesCollectionReference.document('top').get();
      return communitiesData.data;
    } catch (e) {
      return e.message;
    }
  }

  Future getFollowingPostsOnceOff() async {
    print("xdxd");

    try {
      var postDocumentSnapshot = await _followingPostsCollectionReference
          .where("followers", arrayContains: "piqRc5zN4lY6K2ZzEfus")
          .orderBy("lastPost", descending: true)
          .limit(10)
          .getDocuments();
      print(postDocumentSnapshot.documents.toString());
      var data = postDocumentSnapshot.documents.map((doc) => doc.data);
      var lastPosts = [];

      data.forEach((f) => lastPosts.add(f["posts"][0]["id"]));
      print(lastPosts.toString());
      List<QuickStrikePost> listData = new List<QuickStrikePost>();

      lastPosts.forEach((f) async {
        await _postsCollectionReference
            .where("id", isEqualTo: f)
            .limit(1)
            .getDocuments()
            .then((onValue) => onValue.documents.first.data != null
                ? listData
                    .add(QuickStrikePost.fromMap(onValue.documents.first.data))
                : print("it was null"));
      });
      //TODO: HACER RETURN UNA VEZ ACABADA LA CARGA DE POSTS
      return listData;
    } catch (e) {
      print(e.toString());
    }
  }
}
