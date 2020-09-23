import 'dart:async';
import 'package:aldea/models/comment_model.dart';
import 'package:aldea/models/community.dart';
import 'package:aldea/models/community_creation_request.dart';
import 'package:aldea/models/post_model.dart';
import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/models/user_post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final CollectionReference _activityCollectionReference =
      Firestore.instance.collection('activity');

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

      return data;
    } catch (e) {
      return e.message;
    }
  }

  Future<Map<String, dynamic>> getCommunity(String id) async {
    var community = await _communitiesCollectionReference.document(id).get();
    return community.data;
  }

  Future removeRequest(String communityId, String uid) async {
    var reference = await _communitiesCollectionReference
        .document(communityId)
        .collection("requests")
        .where("uid", isEqualTo: uid)
        .getDocuments();

    await reference.documents.first.reference.delete();
  }

  Future deletePost(String uid, String cid) {
    _postsCollectionReference.document(uid).delete();
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
    int number = 0;

    try {
      await _postsCollectionReference
          .document(postId)
          .collection("comments")
          .getDocuments()
          .then((value) => number = value.documents.length);
    } catch (e) {
      print(e.toString() +
          "print del error al intentar pillar el document.length para saber la cantidad de comentarios q hay ");
    }

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

    userRequests.remove(communityId);

    _userCollectionReference
        .document(uid)
        .updateData({"requests": userRequests});
  }

  Future addCommunityFromRequest(String uid, String communityId) async {
    var userInfo = await _userCollectionReference.document(uid).get();
    List userRequests = userInfo.data["communities"];
    userRequests.add(communityId);
    _userCollectionReference
        .document(uid)
        .updateData({"communities": userRequests});

    var followerDocument =
        await _followingPostsCollectionReference.document(communityId).get();
    List followersData = followerDocument.data["followers"];
    followersData.add(uid);
    _followingPostsCollectionReference
        .document(communityId)
        .updateData({"followers": followersData});
  }

  Future registerCommunityActivity(String uid, String imageUrl) async {
    _activityCollectionReference
        .document(uid)
        .setData({"activity": 0, "uid": uid, "picUrl": imageUrl});
  }

  Future addActivityFromRequest(String uid) async {
    var postRef = _userCollectionReference.document(uid);

    await postRef.updateData({"activity": FieldValue.increment(1)});
  }

  Future addActivityFromQuickstrike(String uid) async {
    var postRef = _userCollectionReference.document(uid);
    await postRef.updateData({"activity": FieldValue.increment(2)});
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
      bool isPublic, String communityId, String description) async {
    await _communitiesCollectionReference.document(communityId).updateData({
      'rules': rules,
      'isMarketplace': isMarketplace,
      'isPublic': isPublic,
      'description': description
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
      return listData;
    } catch (e) {
      print(e.toString() + " error print");
      return (e.message);
    }
  }

  Future denyCommunityCreation(String id) async {
    await _communitiesCreationRequestsReference.document(id).delete();
  }

  Future createCommunity(Community community, String id, String userId) async {
    try {
      await _communitiesCollectionReference
          .document(community.uid)
          .setData(community.toJson());
      var userData = await _userCollectionReference.document(userId).get();
      List communities = userData["communities"];
      communities.add(id);
      _userCollectionReference
          .document(userId)
          .updateData({"communities": communities});
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
      if (communityInfo.data["isDeleted"]) {
        var userData = await _userCollectionReference.document(uid).get();
        List communitiesList = userData.data["communities"];
        communitiesList.remove(f);
        await _userCollectionReference
            .document(uid)
            .updateData({"communities": communitiesList});
      } else {
        var community =
            Community.fromData(communityInfo.data, communityInfo.data["uid"]);
        infoList.add(community);
      }
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
      List ids = [];

      postDocumentSnapshot.documents.forEach((element) {
        ids.add(element.documentID);
      });

      var data = postDocumentSnapshot.documents.map((doc) => doc.data);
      int counter = 0;
      List<PostModel> listData = new List<PostModel>();
      data.forEach((
        f,
      ) {
        listData.add(PostModel.fromMap(f, id: ids[counter]));
        counter++;
      });
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
    var id = ref.document().documentID;
    ref.document(id).setData({
      "avatarUrl": avatarUrl,
      "description": description,
      "comments": ({}),
      "communityId": communityId,
      "imageUrl": imageUrl,
      "likes": [],
      "name": name,
      "userId": userId,
      "date": date,
      "commentCount": 0,
      "id": id,
    });
  }

  Future getVouch(String userId) async {
    var userDocument = await _userCollectionReference.document(userId).get();
    var userIdList = userDocument.data["vouches"];
    List<User> userList = new List<User>();

    for (var f in userIdList) {
      await _userCollectionReference
          .where("uid", isEqualTo: f)
          .getDocuments()
          .then((onValue) => onValue.documents.first.exists != null
              ? userList.add(User.fromData(onValue.documents.first.data))
              : print("it was null"));

      return userList;
    }
  }

  Future<List> getCommunitiesList(String uid) async {
    var user = await _userCollectionReference.document(uid).get();
    List communityList = user.data["communities"];
    List<Community> communities = [];
    for (var f in communityList) {
      var community = await _communitiesCollectionReference.document(f).get();
      communities.add(Community.fromData(community.data, f));
    }
    return communities;
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

  Future<List<PostModel>> getPosts(List<dynamic> communityIds) async {
    List<PostModel> posts = [];
    List<List<String>> lists = [];
    List<String> list = [];

    for (var i = 0; i < communityIds.length; i++) {
      list.add(communityIds[i]);
      if (list.length == 10 || (i + 1) == communityIds.length) {
        lists.add(list);
        list = [];
      }
    }
    try {
      await Future.forEach(lists, (list) async {
        var postsResult = await _postsCollectionReference
            .where("communityId", whereIn: list)
            .orderBy("fechaQuickstrike", descending: true)
            .limit(10)
            .getDocuments();
        postsResult.documents.forEach((doc) {
          var post = PostModel.fromMap(doc.data, id: doc.documentID);
          posts.add(post);
        });
        return null;
      });
    } catch (e) {
      print(e);
    }
    return posts;
  }

  Future getFollowingPostsOnceOff(String uid) async {
    try {
      var postDocumentSnapshot = await _followingPostsCollectionReference
          .where("followers", arrayContains: uid)
          .orderBy("lastPost", descending: true)
          .limit(5)
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
      for (var f in lastPosts) {
        await _postsCollectionReference.document(f).get().then((onValue) {
          if (onValue.data != null) {
            listData.add(PostModel.fromMap(onValue.data, id: f));
          } else {}
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
      'rules': snapshot.data["rules"],
      'description': snapshot.data["description"]
    });
    return map;
  }

  Future<List<DocumentSnapshot>> getFirstCommunities() async {
    try {
      var communitiesQuery = await _communitiesCollectionReference
          .orderBy("followerCount", descending: true)
          .limit(12)
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

  Future<List<PostModel>> getMorePosts(List<dynamic> communityIds, Timestamp d,
      {int limit = 9}) async {
    List<PostModel> posts = [];
    List<List<String>> lists = [];
    List<String> list = [];

    for (var i = 0; i < communityIds.length; i++) {
      list.add(communityIds[i]);
      if (list.length == 10 || (i + 1) == communityIds.length) {
        lists.add(list);
        list = [];
      }
    }
    try {
      await Future.forEach(lists, (list) async {
        var postsResult = await _postsCollectionReference
            .where("communityId", whereIn: list)
            .where("fechaQuickstrike", isLessThan: d)
            .orderBy("fechaQuickstrike", descending: true)
            .limit(10)
            .getDocuments();
        postsResult.documents.forEach((doc) {
          var post = PostModel.fromMap(doc.data, id: doc.documentID);
          posts.add(post);
        });
        return null;
      });
    } catch (e) {
      print(e);
    }
    return posts;
  }

  Future<List<Map<String, dynamic>>> getTopCommunities() async {
    try {
      var communitiesData = await _activityCollectionReference
          .orderBy("activity", descending: true)
          .limit(3)
          .getDocuments();
      List<Map<String, dynamic>> documentsData = [];
      communitiesData.documents.forEach((element) {
        documentsData.add(element.data);
      });
      return documentsData;
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
      List winners = [];
      int amount = postSnapshot.data["amount"];
      postSnapshot.data["winners"] == null
          ? null
          : winners = postSnapshot.data["winners"];
      if (postSnapshot.data["finished"] == false && winners.length < amount) {
        winners.add(userId);
        tx.update(docRef, {"winners": winners});
        if (winners.length >= amount) {
          tx.update(docRef, {"finished": true});
        }
        return true;
      } else {
        return false;
      }
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

  Future<QuerySnapshot> getCommunityUsers(String uid) async {
    return _userCollectionReference
        .where("communities", arrayContains: uid)
        .getDocuments();
  }

  Future<bool> deleteUserCommunityPosts(
    String id,
    String communityId,
  ) async {
    print(id + " sdgao     " + communityId);
    await _communitiesCollectionReference
        .document(communityId)
        .collection("userPosts")
        .document(id)
        .delete();
    return true;
  }

  Future<QuerySnapshot> getCommunityUsersSearch(String uid, String name) {
    return _userCollectionReference
        .where("communities", arrayContains: uid)
        .where("username", arrayContains: name)
        .getDocuments();
  }

  Future giveCommunityMod(String communityId, String uid) async {
    var communityData =
        await _communitiesCollectionReference.document(communityId).get();
    List moderatorList = communityData.data["moderators"];
    moderatorList.add(uid);
    _communitiesCollectionReference
        .document(communityId)
        .updateData({"moderators": moderatorList});
    var userData = await _userCollectionReference.document(uid).get();
    List modList = userData.data["mod"];
    modList.add(communityId);
    _userCollectionReference.document(uid).updateData({"mod": modList});
  }

  Future kickCommunityUser(String communityId, String uid) async {
    var followerDocument =
        await _followingPostsCollectionReference.document(communityId).get();
    List followersData = followerDocument.data["followers"];
    List modData = followerDocument.data["mod"];
    followersData.remove(uid);
    modData.remove(communityId);
    _userCollectionReference.document(uid).updateData({"mod":modData});
    _followingPostsCollectionReference
        .document(communityId)
        .updateData({"followers": followersData});
    var userDocument = await _userCollectionReference.document(uid).get();
    List userCommunities = userDocument.data["communities"];
    userCommunities.remove(communityId);
    _userCollectionReference
        .document(uid)
        .updateData({"communities": userCommunities});

    var communityData =
        await _communitiesCollectionReference.document(communityId).get();
    List moderatorList = communityData.data["moderators"];
    if (moderatorList.contains(uid)) {
      moderatorList.remove(uid);
      _communitiesCollectionReference
          .document(communityId)
          .updateData({"moderators": moderatorList});
    }
  }

  void deleteCommunity(String communityId, String communityName) {
    _communitiesCollectionReference
        .document(communityId)
        .setData({"isDeleted": true, "name": communityName});
    _followingPostsCollectionReference.document(communityId).delete();
  }
}
