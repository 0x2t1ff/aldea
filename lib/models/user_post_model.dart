import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserPostModel {
  final List<dynamic> imageUrl;
  final String name;
  final String userId;
  final String communityId;
  final String description;
  final Timestamp date;
  final String id;
  final String avatarUrl;
  final List<dynamic> likes;
  final Map comments;

  UserPostModel({
    @required this.name, 
    @required this.userId,
    @required this.communityId,
    @required this.description,
    @required this.date,
    @required this.comments,
    @required this.avatarUrl,
    @required this.imageUrl,
    @required this.id,
    @required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'name':name,
      'communityId': communityId,
      'userId': userId,
      'imageUrl': imageUrl,
      'description': description,
      'date': date,
      'likes': likes,
      'comments': comments,
    };
  }

  static UserPostModel fromMap(Map<String, dynamic> map) {
    return UserPostModel(
      name:map["name"],
        imageUrl: map['imageUrl'],
        userId: map['userId'],
        description: map['description'],
        date: map['date'],
        id: map['id'],
        communityId: map['communityId'],
        avatarUrl: map['avatarUrl'],
        likes: map['likes'],
        comments: map['comments']);
  }
}
