import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MessageModel {
  final bool isRead;
  final String message;
  final String senderId;
  final Timestamp createdAt;
  final String username;
  final String imageUrl;
  final bool isImage;

  MessageModel({
    @required this.message,
    @required this.isImage,
    @required this.senderId,
    @required this.createdAt,
    this.username,
    this.isRead = false,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'createdAt': createdAt,
    };
  }

  static MessageModel fromMap(Map<dynamic, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      message: map['message'],
      createdAt: map['createdAt'],
      username: map["username"],
      imageUrl: map["imageUrl"],
      isImage: map["isImage"],
    );
  }
}
