
import 'package:flutter/foundation.dart';

class ChatRoomModel {
  final String username;
  final bool isRead;
  final String message;
  final String senderId;
  final String time;
  final bool isImage;
  
  

  ChatRoomModel({
    this.isImage,
    this.time,
    this.message, 
    this.senderId,
    this.isRead,
    @required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'isRead':isRead,
      'time' : time, 
      'senderId': senderId,
      'message': message,
      'isImage': isImage,
    };
  }

  static ChatRoomModel fromMap(Map<dynamic, dynamic> map) {
    return ChatRoomModel(
      message: map['message'],
      time: map['time'],
      isRead: map['isRead'],
      senderId: map['senderId'],
      username: map['username'],
      isImage: map["isImage"],
    );
  }
}
