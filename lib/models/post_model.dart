import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class PostModel {
  final String title;
  final List<dynamic> imageUrl;
  final String communityName;
  final String userId;
  final String communityId;
  final bool isRandom;
  final bool isLista;
  final bool isGame;
  final int amount;
  final String modelo;
  final String description;
  final Timestamp fechaQuickstrike;
  final String id;
  final bool isAnnouncement;
  final String avatarUrl;
  final bool isResult;
  final List<dynamic> winners;
  final int likes;
  final List<dynamic> comments;
  

  PostModel({
    @required this.userId,
    @required this.communityName,
    @required this.communityId,
    @required this.title,
    @required this.modelo,
    @required this.description,
    @required this.fechaQuickstrike,
    @required this.comments,
    @required this.amount,
    @required this.avatarUrl,
    @required this.isResult,
    @required this.isAnnouncement,
    @required this.winners,
    @required this.isGame,
    @required this.isLista,
    @required this.isRandom,
    @required this.imageUrl,
    @required this.id,
    @required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'communityId': communityId,
      'amount': amount,
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
      'isRandom': isRandom,
      'isLista': isLista,
      'isGame': isGame,
      'modelo': modelo,
      'description': description,
      'fechaQuickstrike': fechaQuickstrike,
      'isAnnouncement': isAnnouncement,
      'isResult': isResult,
      'winners': winners,
      'likes':likes,
      'comments':comments,
      'communityName' : communityName,
    };
  }

  static PostModel fromMap(Map<String, dynamic> map) {
    return PostModel(
      communityName: map['communityName'],
        title: map['title'],
        imageUrl: map['imageUrl'],
        userId: map['userId'],
        isGame: map['isGame'],
        isRandom: map['isRandom'],
        isLista: map['isLista'],
        description: map['description'],
        modelo: map['modelo'],
        fechaQuickstrike: map['fechaQuickstrike'],
        id: map['id'],
        isAnnouncement: map['isAnnouncement'],
        isResult: map['isResult'],
        communityId: map['communityId'],
        amount: map['amount'],
        avatarUrl: map['avatarUrl'],
        likes: map['likes'],
        comments: map['comments'],
        winners: map['winners']);
  }
}
