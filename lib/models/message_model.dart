
import 'package:flutter/foundation.dart';

class MessageModel {
  final bool isRead;
  final String message;
  final String senderId;
  final String time;
  final String username;
  final String imageUrl;
  final bool isImage;

  MessageModel({
    @required this.message,
    @required this.isImage,
    @required this.senderId,
    @required this.time,
    this.username,
    this.isRead = false,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'time': time,
    };
  }

  static MessageModel fromMap(Map<dynamic, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      message: map['message'],
      time: map['time'],
      username: map["username"],
      imageUrl: map["imageUrl"],
      isImage: map["isImage"],
    );
  }
}
