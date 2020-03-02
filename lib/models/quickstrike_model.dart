import 'package:cloud_firestore/cloud_firestore.dart';
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
  final Timestamp fechaQuickstrike;
  final String id;
  QuickStrikePost({
    @required this.userId,
    @required this.title,
    @required this.price,
    @required this.modelo,
    @required this.description,
    @required this.fechaQuickstrike,
    this.isGame,
    this.isLista,
    this.isRandom,
    this.imageUrl,
    this.id,
    
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
      'id' : id,
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
      isLista: map ['isLista'],
      description: map['description'],
      modelo: map['modelo'],
      fechaQuickstrike: map['fechaQuickstrike'],
      id:map['id']
      
    );
  }
}
