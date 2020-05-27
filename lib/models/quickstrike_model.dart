import 'package:cloud_firestore/cloud_firestore.dart';

class QuickStrikePost {
  final String title;
  final List<dynamic> imageUrl;
  final String userId;
  final double price;
  final bool isRandom;
  final bool isLista;
  final bool isGame;
  final String modelo;
  final String description;
  final Timestamp fechaQuickstrike;
  final String id;
  final String communityName;
  final String profilePic;
  final bool isEmpty;
  final bool finished;
  QuickStrikePost({
    this.userId,
    this.title,
    this.price,
    this.modelo,
    this.description,
    this.fechaQuickstrike,
    this.profilePic,
    this.isGame,
    this.communityName,
    this.isLista,
    this.isRandom,
    this.imageUrl,
    this.id,
    this.isEmpty,
    this.finished
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
      'price': price,
      'isRandom': isRandom,
      'isLista': isLista,
      'isGame': isGame,
      'modelo': modelo,
      'description': description,
      'fechaQuickstrike': fechaQuickstrike,
      'id': id,
      'communityName': communityName,
      'profilePic': profilePic,
      'isEmpty': isEmpty,
      'finished': finished,
    };
  }

  static QuickStrikePost fromMap(Map<String, dynamic> map) {
    return QuickStrikePost(
      title: map['title'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      price: map['price'],
      isGame: map['isGame'],
      isRandom: map['isRandom'],
      isLista: map['isLista'],
      description: map['description'],
      modelo: map['modelo'],
      fechaQuickstrike: map['fechaQuickstrike'],
      id: map['id'],
      profilePic: map['profilePic'],
      communityName: map['communityName'],
      isEmpty: map['isEmpty'],
      finished:  map['finished']
    );
  }
}
