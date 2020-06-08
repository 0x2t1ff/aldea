import 'package:firebase_database/firebase_database.dart';

class RtdbService {
  FirebaseDatabase _database = FirebaseDatabase.instance;
 
  Stream<Event> fetchChatMessages(String chatRoomId) {
    return _database.reference().child('messages/$chatRoomId').onValue;
  }

  Stream<Event> fetchCommunityChatMessages(String communityId){
    return _database.reference().child("communitiesChatRooms/$communityId").onValue;
  }

  String createChatRoom(List<dynamic> userIds, List<dynamic> images) {
    //Crea la CHAT ROOM con los users y devuelve su ID
  Map avatarUrls;
  avatarUrls = { userIds[0]:images[0],userIds[1]:images[1]};
    var ref = _database.reference().child('chatRooms/').push()
      ..set({'users': userIds,"avatarUrl":avatarUrls });
    return ref.key;
  }
// asignar metodo junto creación de comunidad , comprobar lógica.
  String createCommunityChatRoom(String cid){
    var ref = _database.reference().child("communitiesChatRooms/$cid");
    return ref.key;
  }


  void sendCommunityMessage({String communityId, String message, String senderId, String username, String imageUrl, bool isImage}){
    var time = DateTime.now().toString();
    var path =  _database.reference().child("communitiesChatRooms/$communityId").push();

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
  

  void sendMessage({String chatRoomId, String message, String senderId, String username, String imageUrl, bool isImage}) {
    var time = DateTime.now().toString();
    var path = _database.reference().child('messages/$chatRoomId/').push();
    
    path.set({
      'message': message,
      'senderId': senderId,
      'isRead': false,
      'time': time,
      'username': username,
      'imageUrl': imageUrl,
      'isImage': isImage
    }).then((value) =>
        _database.reference().child('chatRooms/$chatRoomId/').update({
          'lastMessage': {
            'message': message,
            'senderId': senderId,
            'isRead': false,
            'time': time,
            'username': username,
            'imageUrl': imageUrl,
            'isImage' : isImage,
          }
        }),);
  }

  List<Stream<Event>> getChats(List<dynamic> chatRoomIds) {
    List<Stream<Event>> streams = [];
    for (var chatRoomId in chatRoomIds) {
      streams
          .add(_database.reference().child('chatRooms/$chatRoomId/').onValue);
    }
    return streams;
  }

  void readMessage(String chatRoomId, String messageId) {
    _database
        .reference()
        .child('messages/$chatRoomId/$messageId')
        .update({'isRead': true}).then((value) => _database
            .reference()
            .child('chatRooms/$chatRoomId/lastMessage')
            .update({'isRead': true}));
  }
}
