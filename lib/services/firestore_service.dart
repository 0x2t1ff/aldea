import 'dart:async';

import 'package:aldea/models/comment_model.dart';
import 'package:aldea/models/community.dart';
import 'package:aldea/models/community_creation_request.dart';
import 'package:aldea/models/post_model.dart';
import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/models/user_post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
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
  final CollectionReference _communitiesCreationRequestsReference =
      Firestore.instance.collection('communityRequests');

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

  Future removeRequest(String communityId, String uid) async {
    var reference = await _communitiesCollectionReference
        .document(communityId)
        .collection("requests")
        .where("uid", isEqualTo: uid)
        .getDocuments();

    await reference.documents.first.reference.delete();
  }

  Future<List<CommentModel>> getUserComments(
      String postId, String communityId) async {
    try {
      var result = await _communitiesCollectionReference
          .document(communityId)
          .collection("userPosts")
          .document(postId)
          .collection("comments")
          .getDocuments();

      var data = result.documents.map((doc) => doc.data);
      List<CommentModel> listData = new List<CommentModel>();
      data.forEach((f) => listData.add(CommentModel.fromData(f)));
      print(listData.toString() + " the print of data");
      print(data.length.toString());
      listData.sort((a, b) {
        return a.date.compareTo(b.date);
      });
      return listData;
    } catch (e) {
      print(e.toString() + " printing the error data");
    }
  }

  Future<List<CommentModel>> getComments(String postId) async {
    try {
      var result = await _postsCollectionReference
          .document(postId)
          .collection("comments")
          .getDocuments();

      var data = result.documents.map((doc) => doc.data);
      List<CommentModel> listData = new List<CommentModel>();
      data.forEach((f) => listData.add(CommentModel.fromData(f)));
      print(listData.toString() + " the print of data");
      print(data.length.toString());
      listData.sort((a, b) {
        return a.date.compareTo(b.date);
      });
      return listData;
    } catch (e) {
      print(e.toString() + " printing the error data");
    }
  }

  Future postComment(
      String postId, String text, String name, String uid) async {
    _postsCollectionReference
        .document(postId)
        .collection("comments")
        .document()
        .setData({
      'text': text,
      'name': name,
      'uid': uid,
      'date': DateTime.now().toString()
    });
    int number;
    await _postsCollectionReference
        .document(postId)
        .collection("comments")
        .getDocuments()
        .then((value) => number = value.documents.length);

    await _postsCollectionReference
        .document(postId)
        .updateData({"commentCount": number});
  }

  Future postUserComment(String communityId, String postId, String text,
      String name, String uid) async {
    _communitiesCollectionReference
        .document(communityId)
        .collection("userPosts")
        .document(postId)
        .collection("comments")
        .document()
        .setData({
      'text': text,
      'name': name,
      'uid': uid,
      'date': DateTime.now().toString()
    });
    int number;
    await _communitiesCollectionReference
        .document(communityId)
        .collection("userPosts")
        .document(postId)
        .collection("comments")
        .getDocuments()
        .then((value) => number = value.documents.length);

    await _communitiesCollectionReference
        .document(communityId)
        .collection("userPosts")
        .document(postId)
        .updateData({"commentCount": number});
  }

  Future removeRequestUser(String communityId, String uid) async {
    var userInfo = await _userCollectionReference.document(uid).get();
    List userRequests = userInfo.data["requests"];
    print(userRequests);
    userRequests.remove(communityId);
    print(userRequests);
    _userCollectionReference
        .document(uid)
        .updateData({"requests": userRequests});
  }

  Future addCommunityFromRequest(String uid, String communityId) async {
    var userInfo = await _userCollectionReference.document(uid).get();
    List userRequests = userInfo.data["communities"];
    userRequests.add(uid);
    _userCollectionReference
        .document(uid)
        .updateData({"communities": userRequests});
  }

  Future followCommunity(String uid, String communityId) async {
    var followDoc =
        await _followingPostsCollectionReference.document(communityId).get();
    List followers = followDoc.data["followers"];

    followers.add(communityId);
    await _followingPostsCollectionReference
        .document(communityId)
        .updateData({"followers": followers});
  }

  Future updateCommunitySettings(String rules, bool isMarketplace,
      bool isPublic, String communityId) async {
    await _communitiesCollectionReference.document(communityId).updateData({
      'rules': rules,
      'isMarketplace': isMarketplace,
      'isPublic': isPublic,
    });
  }

  Future<List<UserPostModel>> getUserPosts(String uid) async {
    try {
      var result = await _communitiesCollectionReference
          .document(uid)
          .collection('userPosts')
          .orderBy("date", descending: true)
          .limit(10)
          .getDocuments();

      var data = result.documents.map((doc) => doc.data);
      List<UserPostModel> listData = new List<UserPostModel>();
      data.forEach((f) => listData.add(UserPostModel.fromMap(f)));
      print(listData.toString() + " the print of data");
      return listData;
    } catch (e) {
      print(e.toString() + " error print");
      return (e.message);
    }
  }

  Future denyCommunityCreation(String id) async {
    await _communitiesCreationRequestsReference.document(id).delete();
  }

  Future createCommunity(Community community, String id) async {
    try {
      await _communitiesCollectionReference
          .document(community.uid)
          .setData(community.toJson());
    } catch (e) {
      //TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<DocumentReference> createRequestId() async {
    var documentPath = await _communitiesCreationRequestsReference.document();
    return documentPath;
  }

  Future createCommunityCreationRequest(
      User user,
      String messageRequest,
      String bkdPicUrl,
      String name,
      String communityRules,
      String description,
      String iconPicUrl,
      DocumentReference documentPath) async {
    documentPath.setData({
      'user': user.toJson(),
      'messageRequest': messageRequest,
      'bkdPicUrl': bkdPicUrl,
      'name': name,
      'communityRules': communityRules,
      'description': description,
      'iconPicUrl': iconPicUrl,
      'id': documentPath.documentID
    });
  }

  Future<List<CommunityCreationRequest>> getAdminRequests() async {
    List<CommunityCreationRequest> requestsList = [];
    var requests = await _communitiesCreationRequestsReference.getDocuments();
    requests.documents.forEach((element) {
      requestsList.add(CommunityCreationRequest.fromData(element.data));
    });
    return requestsList;
  }

  Future<List<dynamic>> getFollowingCommunities(String uid) async {
    var followingCommunities =
        await _userCollectionReference.document(uid).get();

    return followingCommunities.data["communities"];
  }

  Future getUser(String uid) async {
    var userData = await _userCollectionReference.document(uid).get();
    return User.fromData(userData.data);
  }

  Future<List<Community>> getCommunitiesData(
      List<dynamic> communitiesList, String uid) async {
    List<Community> infoList = List();

    for (var f in communitiesList) {
      var communityInfo =
          await _communitiesCollectionReference.document(f).get();

      var community =
          Community.fromData(communityInfo.data, communityInfo.data["uid"]);
      infoList.add(community);
    }

    return infoList;
  }

  Future createUser(User user) async {
    try {
      await _userCollectionReference.document(user.uid).setData(user.toJson());
    } catch (e) {
      //TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future<List> getVouchList(String uid) async {
    var user = await _userCollectionReference.document(uid).get();
    List vouchList = user.data["vouches"];
    return vouchList;
  }

  Future giveVouch(List vouchList, String uid) async {
    await _userCollectionReference
        .document(uid)
        .updateData({"vouches": vouchList});
  }

  Future writeNewChatRoom(String id, String otherId, String chatRoomId) async {
    var postRef = _userCollectionReference.document(id);
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(postRef);
      List list = postSnapshot.data["chatRooms"];
      list.add(chatRoomId);
      await tx.update(postRef, <String, dynamic>{"chatRooms": list});
    });
  }

  Future getNewsPosts(String uid) async {
    try {
      var postDocumentSnapshot = await _postsCollectionReference
          .where("communityId", isEqualTo: uid)
          .orderBy("fechaQuickstrike", descending: true)
          .limit(10)
          .getDocuments();

      var data = postDocumentSnapshot.documents.map((doc) => doc.data);
      List<PostModel> listData = new List<PostModel>();
      data.forEach((f) => listData.add(PostModel.fromMap(f)));
      return listData;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> likePost(
      List<dynamic> likeList, String postId, bool liked) async {
    await _postsCollectionReference
        .document(postId)
        .updateData({"likes": likeList});
    return !liked;
  }

  Future createUserPost(String communityId, List imageUrl, String description,
      String avatarUrl, String name, String userId, DateTime date) {
    var ref = _communitiesCollectionReference
        .document(communityId)
        .collection("userPosts");
    ref.document().setData({
      "avatarUrl": avatarUrl,
      "description": description,
      "comments": ({}),
      "communityId": communityId,
      "imageUrl": imageUrl,
      "likes": [],
      "name": name,
      "userId": userId,
      "date": date,
      "commentCount": 0
    });
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

  Future<String> addPost(Map<dynamic, dynamic> post) async {
    try {
      var doc = await _postsCollectionReference.add(post);
      return doc.documentID;
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
      var data = postDocumentSnapshot.documents.map((doc) => doc.data);
      List lastPostsList = [];

      data.forEach((f) => lastPostsList.add(f["posts"]));
      var lastPosts = [];
      lastPostsList.forEach((element) {
        element.forEach((element) {
          lastPosts.add(element["id"]);
        });
      });

      List<PostModel> listData = new List<PostModel>();
      print(lastPosts);
      for (var f in lastPosts) {
        await _postsCollectionReference.document(f).get().then((onValue) {
          if (onValue.data != null) {
            listData.add(PostModel.fromMap(onValue.data));
          } else {
            print("it was null");
          }
        });
      }
      //TODO: HACER RETURN UNA VEZ ACABADA LA CARGA DE POSTS
      listData.sort((a, b) {
        return a.fechaQuickstrike.compareTo(b.fechaQuickstrike);
      });

      return listData.reversed.toList();
    } catch (e) {
      print(e.toString());
    }
  }

  Future addPostToFollowing(
      String communityId, List<dynamic> posts, Timestamp lastPost) async {
    try {
      await _followingPostsCollectionReference
          .document(communityId)
          .setData({'posts': posts, 'lastPost': lastPost}, merge: true);
    } catch (e) {
      return (e.messages);
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
          .setData({
        'isFromFB': isFromFB,
        "uid": user.uid,
        'text': text,
        'user': user.toJson()
      });
      await _userCollectionReference
          .document(user.uid)
          .updateData({'requests': user.requests..add(communityUid)});
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> getSettings(String communityId) async {
    var snapshot =
        await _communitiesCollectionReference.document(communityId).get();
    var map = ({
      'isPublic': snapshot.data["isPublic"],
      'isMarketplace': snapshot.data["isMarketplace"],
      'rules': snapshot.data["rules"]
    });
    return map;
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

  Future createFollowersDoc(String communityId) async {
    try {
      await _followingPostsCollectionReference.document(communityId).setData({
        'followers': [],
        'posts': [],
        'quickstrikes': [],
        'uid': communityId,
      });
    } catch (e) {
      return (e.messages);
    }
  }

  Future getCommunityFollowersDoc(String communityId) async {
    try {
      var result =
          await _followingPostsCollectionReference.document(communityId).get();
      return result.data;
    } catch (e) {}
  }

  Future addQsToFollowing(
      String communityId, List<dynamic> qs, Timestamp lastQs) async {
    try {
      await _followingPostsCollectionReference.document(communityId).setData(
          {'quickstrikes': qs, 'lastQuickstrike': lastQs},
          merge: true);
    } catch (e) {
      return (e.messages);
    }
  }

  //      **QUICKSTRIKE METHODS**

  Future<String> addQuickstrike(QuickStrikePost post) async {
    try {
      var doc = await _quickstrikeCollectionReference.add(post.toMap());
      doc.updateData({'id': doc.documentID});
      return doc.documentID;
    } catch (e) {
      return e.toString();
    }
  }

  Future getQuickstrike(String uid) async {
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

      List<Stream> listData = [];
      for (var lastPost in lastPosts) {
        listData.add(
            _quickstrikeCollectionReference.document(lastPost).snapshots());
      }

      var mergedStream = Rx.combineLatestList(listData);

      return mergedStream;
    } catch (e) {
      print(e.toString());
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

  Future submitQuickstrikeResult(String id, String userId) async {
    var docRef = _quickstrikeCollectionReference.document(id);
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot postSnapshot = await tx.get(docRef);
      print(postSnapshot.data);
      int amount = postSnapshot.data["amount"];
      List winners = postSnapshot.data["winners"];
      if (postSnapshot.data["finished"] == false && winners.length < amount) {
        winners.add(userId);
        print(winners);
        tx.update(docRef, {"winners": winners});
        if (winners.length >= amount) {
          tx.update(docRef, {"finished": true});
        }
      } else {}
    }).catchError((error) => print(error.toString()));
  }

  Future getParticipatingQuickstrikes(String uid, String qid) async {
    var docRef = await _userCollectionReference
        .document(uid)
        .collection("pQuickstrikes")
        .document(qid)
        .get();

    if (docRef.data == null) {
      return false;
    } else {
      return true;
    }
  }

  Stream<DocumentSnapshot> getChats(String uid) {
    try {
      var stream = _userCollectionReference.document(uid).snapshots();
      return stream;
    } catch (e) {
      return (e.message);
    }
  }
}
