import 'package:flutter/foundation.dart';

class QuickStrikePost {
  final String title;
  final String imageUrl;
  final String userId;
  final double price; 
  final bool isRandom;
  final bool isLista;
  final bool isGame;
  final String modelo;
  final String description;
  QuickStrikePost({
    @required this.userId,
    @required this.title,
    @required this.price,
    @required this.modelo,
    @required this.description,
    this.isGame,
    this.isLista,
    this.isRandom,
    this.imageUrl,
    
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
    };
  }

  static QuickStrikePost fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return QuickStrikePost(
      title: map['title'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      price: map['price'],
      isGame: map['isGame'],
      isRandom: map['isRandom'],
      isLista: map ['isLista'],
      description: map['description'],
      modelo: map['modelo'],
      
    );
  }
}
