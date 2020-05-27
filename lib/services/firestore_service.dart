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

  //      **USER METHODS**
  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      var userData = await _userCollectionReference.document(uid).get();
      var docs = await _userCollectionReference
          .document(uid)
          .collection("pQuickstrikes")
          .where("fechaQuickstrike", isGreaterThanOrEqualTo: Timestamp.now())
          .getDocuments();
      List<String> onGoingQuickstrikes = [];
      for (var doc in docs.documents) {
        onGoingQuickstrikes.add(doc.documentID);
      }
      Map<dynamic, dynamic> data = userData.data;
      data.putIfAbsent("onGoingQuickstrikes", () => onGoingQuickstrikes);
      print(data);
      return data;
    } catch (e) {
      return e.message;
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

  Future getVouch(String userId) async {
    var userDocument = await _userCollectionReference.document(userId).get();
    var userIdList = userDocument.data["vouches"];
    List<User> userList = new List<User>();
    print(userIdList);
    for (var f in userIdList) {
      await _userCollectionReference
          .where("uid", isEqualTo: f)
          .getDocuments()
          .then((onValue) => onValue.documents.first.data != null
              ? userList.add(User.fromData(onValue.documents.first.data))
              : print("it was null"));

      return userList;
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

  //      **POSTS METHODS**

  Future addPost(QuickStrikePost post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
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
      for (var f in lastPosts) {
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
      }
      ;
      //TODO: HACER RETURN UNA VEZ ACABADA LA CARGA DE POSTS
      return listData;
    } catch (e) {
      print(e.toString());
    }
  }

  //      **COMMUNITY METHODS**
  Future<List<DocumentSnapshot>> getCommunityRequests(String id) async {
    var documents = await _communitiesCollectionReference
        .document(id)
        .collection("requests")
        .getDocuments();
    return documents.documents;
  }

  Future requestCommunityAccess(
      String communityUid, User user, String text, bool isFromFB) async {
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

  //      **QUICKSTRIKE METHODS**

  Future getQuickstrikes(String uid) async {
    try {
      var postDocumentSnapshot = await _followingPostsCollectionReference
          .where("followers", arrayContains: uid)
          .orderBy("lastQuickstrike", descending: true)
          .limit(20)
          .getDocuments();
      var data = postDocumentSnapshot.documents.map((doc) => doc.data).toList();
      var lastPosts = [];
      data.forEach((value) {
        for (var quickstrike in value['quickstrikes']) {
          if ((quickstrike['date'] as Timestamp).seconds >
              Timestamp.now().seconds) {
            lastPosts.add(quickstrike["id"]);
          }
        }
      });
      List<QuickStrikePost> listData = [];

      for (var lastPost in lastPosts) {
        var doc = await _quickstrikeCollectionReference.document(lastPost).get();
        listData.add(QuickStrikePost.fromMap(doc.data));
      }
      return listData;
    } catch (e) {
      print(e.toString() + " the error");
    }
  }

  Future joinQuickstrike(String userId, Map<String, dynamic> data) async {
    await _userCollectionReference
        .document(userId)
        .collection("pQuickstrikes")
        .document(data["id"])
        .setData(data);
  }

  Future quitQuickstrike(String userId, String quickstrikeId) async {
    await _userCollectionReference
        .document(userId)
        .collection("pQuickstrikes")
        .document(quickstrikeId)
        .delete();
  }
}
