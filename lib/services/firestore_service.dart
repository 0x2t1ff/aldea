import 'dart:async';

import 'package:aldea/models/post_model.dart';
import 'package:aldea/models/quickstrike_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../models/user_model.dart';

class FirestoreService {
  //COLLECTION REFERENCES
  final CollectionReference _userCollectionReference =
      Firestore.instance.collection('users');

  final CollectionReference _postsCollectionReference =
      Firestore.instance.collection('posts');
  final CollectionReference _quickstrikeCollectionReference =
      Firestore.instance.collection('quickstrikes');
  final CollectionReference _communitiesCollectionReference =
      Firestore.instance.collection('communities');
  final CollectionReference _followingPostsCollectionReference =
      Firestore.instance.collection('followers');

  //USER METHODS
  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      var userData = await _userCollectionReference.document(uid).get();
      return userData.data;
    } catch (e) {
      return e.message;
    }
  }

  Future addPost(QuickStrikeModel post) async {
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
          return QuickStrikeModel.fromMap(
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

  //COMMUNITY METHODS
  Future<List<DocumentSnapshot>> getCommunityRequests(String id)async {
    var documents = await _communitiesCollectionReference.document(id).collection("requests").getDocuments();
    return documents.documents;

  }


  Future requestCommunityAccess(String communityUid, User user,String text, bool isFromFB) async {
    try {
      await _communitiesCollectionReference
          .document(communityUid)
          .collection('requests')
          .document(user.uid)
          .setData({'isFromFB': isFromFB, 'text': text, 'user': user.toJson()});
      await _userCollectionReference
          .document(user.uid)
          .updateData({'requests': user.requests..add(communityUid)});
    } catch (e) {
      print(e);
    }
  }


  Future<List<DocumentSnapshot>> getFirstCommunities() async {
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

  Future<List<DocumentSnapshot>> getMoreCommunities(DocumentSnapshot d,
      {int limit = 9}) async {
    try {
      var communitiesQuery = await _communitiesCollectionReference
          .orderBy("followerCount", descending: true)
          .startAfterDocument(d)
          .limit(limit)
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
      print(e.message);
    }
  }

  Future getQuickstrikes(String uid) async {
    try {
      var postDocumentSnapshot = await _followingPostsCollectionReference
          .where("followers", arrayContains: uid)
          .orderBy("lastQuickstrike", descending: true)
          .limit(20)
          .getDocuments();
      var data = postDocumentSnapshot.documents.map((doc) => doc.data);
      var lastPosts = [];
      data.forEach((f) {
        lastPosts.add(f["quickstrikes"][0]["id"]);
      });

      List<QuickStrikeModel> listData = new List<QuickStrikeModel>();

      for(var f in lastPosts ) {
        await _quickstrikeCollectionReference
            .where("id", isEqualTo: f)
            .limit(1)
            .getDocuments()
            .then((onValue) => onValue.documents.first.data != null
                ? listData
                    .add(QuickStrikeModel.fromMap(onValue.documents.first.data))
                : print("it was null"));
      };
      return listData;
    } catch (e) {
      print(e.toString() + " the error");
    }
  }

  Future getFollowingPostsOnceOff(String uid) async {
    try {
      var postDocumentSnapshot = await _followingPostsCollectionReference
          .where("followers", arrayContains: uid)
          .orderBy("lastPost", descending: true)
          .limit(10)
          .getDocuments();
      print(postDocumentSnapshot.documents.toString());
      var data = postDocumentSnapshot.documents.map((doc) => doc.data);
      var lastPosts = [];

      data.forEach((f) => lastPosts.add(f["posts"][0]["id"]));
      List<PostModel> listData = new List<PostModel>();
      int count = 0;
      for(var f in lastPosts) {
        await _postsCollectionReference
            .where("id", isEqualTo: f)
            .limit(1)
            .getDocuments()
            .then((onValue) {
          if (onValue.documents.first.data != null) {
            listData.add(PostModel.fromMap(onValue.documents.first.data));
            count++;
            print(count.toString());
          } else {
            print("it was null");
          }
        });
      };
      //TODO: HACER RETURN UNA VEZ ACABADA LA CARGA DE POSTS
      return listData;
    } catch (e) {
      print(e.toString());
    }
    
  }

  Future<List<DocumentSnapshot>> getProductsFromCommunity(String uid) async {
    try {
      var result = await _communitiesCollectionReference
          .document(uid)
          .collection('market')
          .getDocuments();
      return result.documents;
    } catch (e) {
      return (e.message);
    }
  }
}
