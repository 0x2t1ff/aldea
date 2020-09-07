import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class RtdbService {
  FirebaseDatabase _database = FirebaseDatabase.instance;

  Stream<Event> getChatMessages(String chatRoomId, int limit) {
    var stream = _database
        .reference()
        .child('messages/$chatRoomId')
        .orderByChild("time")
        .limitToLast(limit)
        .onChildAdded;

    return stream;
  }

  Stream<Event> getMoreChatMessages(
      String chatRoomId, int limit, String timestamp) {
    var stream = _database
        .reference()
        .child('messages/$chatRoomId')
        .orderByChild("time")
        .startAt(timestamp)
        .limitToFirst(limit)
        .onChildAdded;

    return stream;
  }

  Stream<Event> fetchCommunityChatMessages(String communityId, int limit) {
    return _database
        .reference()
        .child("communitiesChatRooms/$communityId")
        .orderByChild("time")
        .limitToLast(limit)
        .onChildAdded;
  }

  String createChatRoom(
      List<dynamic> userIds, List<dynamic> images, List usernameList) {
    //Crea la CHAT ROOM con los users y devuelve su ID
    Map avatarUrls;
    Map username;
    avatarUrls = {userIds[0]: images[0], userIds[1]: images[1]};
    username = {userIds[0]: usernameList[0], userIds[1]: usernameList[1]};
    var ref = _database.reference().child('chatRooms/').push()
      ..set({'users': userIds, "avatarUrl": avatarUrls, "username": username});
    return ref.key;
  }

// asignar metodo junto creación de comunidad , comprobar lógica.
  String createCommunityChatRoom(String cid) {
    var ref = _database.reference().child("communitiesChatRooms/$cid");
    return ref.key;
  }

  void sendCommunityMessage(
      {String communityId,
      String message,
      String senderId,
      String username,
      String imageUrl,
      bool isImage}) {
    var time = DateTime.now(); //.toString();
    var path =
        _database.reference().child("communitiesChatRooms/$communityId").push();

    path.set({
      'message': message,
      'senderId': senderId,
      'isRead': false,
      'time': time,
      'username': username,
      'imageUrl': imageUrl,
      'isImage': isImage
    });
  }

  void sendMessage(
      {String chatRoomId,
      String message,
      String senderId,
      String username,
      String imageUrl,
      bool isImage}) async {
    var time = DateTime.now().toString();
    var path = _database.reference().child('messages/$chatRoomId/').push();
    var chatroom = await _database
        .reference()
        .child("chatRooms")
        .child("$chatRoomId")
        .once();
    var userIds = chatroom.value["users"];
    String otherUser;
    if (userIds[0] == senderId) {
      otherUser = userIds[1];
    } else {
      otherUser = userIds[0];
    }

    path.set({
      'message': message,
      'senderId': senderId,
      'isRead': false,
      'time': time,
      'username': username,
      'imageUrl': imageUrl,
      'isImage': isImage,
      'otherId': otherUser,
    }).then((value) async {
      var query =
          await _database.reference().child('chatRooms/$chatRoomId/').once();
      Map unreadMessages = query.value["unreadMessages"];
      print(unreadMessages);
      unreadMessages.update(otherUser, (value) {
        return value + 1;
      });

      _database.reference().child('chatRooms/$chatRoomId/').update({
        'lastMessage': {
          'message': message,
          'senderId': senderId,
          'isRead': false,
          'time': time,
          'username': username,
          'imageUrl': imageUrl,
          'isImage': isImage,
        },
        "unreadMessages": unreadMessages
      });
    });
  }

  List<Stream<Event>> getChats(List<dynamic> chatRoomIds) {
    List<Stream<Event>> streams = [];
    for (var chatRoomId in chatRoomIds) {
      streams
          .add(_database.reference().child('chatRooms/$chatRoomId/').onValue);
    }
    return streams;
  }

  void readMessage(String chatRoomId, currentUser) async {
    var chatroom = await _database
        .reference()
        .child("chatRooms")
        .child("$chatRoomId")
        .once();
    var userIds = chatroom.value["users"];
    String otherUser;
    if (userIds[0] == currentUser) {
      otherUser = userIds[1];
    } else {
      otherUser = userIds[0];
    }

    var query =
        await _database.reference().child('chatRooms/$chatRoomId/').once();
    Map unreadMessages = query.value["unreadMessages"];
    print(unreadMessages);
    unreadMessages.update(currentUser, (value) {
      return 0;
    });
    _database
        .reference()
        .child('chatRooms/$chatRoomId/')
        .update({"unreadMessages": unreadMessages});
  }
}
