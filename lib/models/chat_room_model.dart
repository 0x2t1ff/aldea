import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatRoomModel {
  final String username;
  final bool isRead;
  final String lastMessage;
  final String senderId;
  final Timestamp lastMessageSentAt;
  final Map avatarUrls;
  final bool isImage;
  final List<dynamic> users;
  final Map usernames;

  ChatRoomModel({
    this.isImage,
    this.lastMessageSentAt,
    this.lastMessage,
    this.senderId,
    this.isRead,
    this.users,
    this.avatarUrls,
    this.usernames,
    @required this.username,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'isRead': isRead,
      'lastMessageSentAt': lastMessageSentAt,
      'senderId': senderId,
      'lastMessage': lastMessage,
      'isImage': isImage,
      'avatarUrls': avatarUrls,
      'users': users,
      'usernames': usernames
    };
  }

  static ChatRoomModel fromMap(Map<dynamic, dynamic> map) {
    return ChatRoomModel(
        lastMessage: map['lastMessage'],
        lastMessageSentAt: map['lastMessageSentAt'],
        isRead: map['isRead'],
        senderId: map['senderId'],
        username: map['username'],
        isImage: map["isImage"],
        avatarUrls: map["avatarUrls"],
        usernames: map["usernames"],
        users: map["users"]);
  }
}
