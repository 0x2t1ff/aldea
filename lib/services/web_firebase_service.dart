import "package:firebase/firebase.dart";

class WebRTDBService {
  var messagesRef = database().ref("messages");
  var communitiesChatRoomsRef = database().ref("communitiesChatRooms");
  var chatRoomsRef = database().ref("chatRooms");

  Stream fetchChatMessages(String chatRoomId) {
    return messagesRef.child(chatRoomId).onValue;
  }

  void sendCommunityMessage(
      {String communityId,
      String message,
      String senderId,
      String username,
      String imageUrl,
      bool isImage}) {
    var time = DateTime.now().toString();
    var path = communitiesChatRoomsRef.child(communityId).push();

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

  String createCommunityChatRoom(String cid) {
    var dbref = communitiesChatRoomsRef.child(cid);
    return dbref.key;
  }

  String createChatRoom(
      List<dynamic> userIds, List<dynamic> images, List usernameList) {
    //Crea la CHAT ROOM con los users y devuelve su ID
    Map avatarUrls;
    Map username;
    avatarUrls = {userIds[0]: images[0], userIds[1]: images[1]};
    username = {userIds[0]: usernameList[0], userIds[1]: usernameList[1]};
    var dbref = chatRoomsRef.push()
      ..set({'users': userIds, "avatarUrl": avatarUrls, "username": username});
    return dbref.key;
  }

  Stream<QueryEvent> fetchCommunityChatMessages(String communityId) {
    messagesRef.child("testing").set({"test": "test"});
    return communitiesChatRoomsRef.child(communityId).onValue;
  }

  void sendMessage(
      {String chatRoomId,
      String message,
      String senderId,
      String username,
      String imageUrl,
      bool isImage}) async {
    var time = DateTime.now().toString();
    var path = messagesRef.child(chatRoomId).push();
    // will probably have issue getting the snapshot https://pub.dev/documentation/firebase/latest/firebase_firestore/Query-class.html
    var userIds;

    chatRoomsRef.child(chatRoomId).onValue.listen((event) {
      userIds = event.snapshot.val()["users"];
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
      }).then(
        (value) => chatRoomsRef.child(chatRoomId).update({
          'lastMessage': {
            'message': message,
            'senderId': senderId,
            'isRead': false,
            'time': time,
            'username': username,
            'imageUrl': imageUrl,
            'isImage': isImage,
          }
        }),
      );
    }).cancel();
    //canel subscription after the message is sent
  }

  List<Stream<QueryEvent>> getChats(List<dynamic> chatRoomIds) {
    List<Stream<QueryEvent>> streams = [];
    for (var chatRoomId in chatRoomIds) {
      streams.add(chatRoomsRef.child(chatRoomId).onValue);
    }
    return streams;
  }

  void readMessage(String chatRoomId, String messageId) {
    messagesRef.child('$chatRoomId/$messageId').update({'isRead': true}).then(
        (value) => chatRoomsRef
            .child('$chatRoomId/lastMessage')
            .update({'isRead': true}));
  }
}
