import 'package:firebase_database/firebase_database.dart';

class RtdbService {
  FirebaseDatabase _database = FirebaseDatabase.instance;

  Stream<Event> fetchChatMessages(String chatRoomId) {
    return _database.reference().child('messages/$chatRoomId').onValue;
  }

  String createChatRoom(List<String> userIds) {
    //Crea la CHAT ROOM con los users y devuelve su ID
    var ref = _database.reference().child('chatRooms/').push()
      ..set({'users': userIds});
    return ref.key;
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
