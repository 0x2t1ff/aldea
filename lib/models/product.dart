import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final String model;
  final double price;
  final List<dynamic> imagesList;
  final Timestamp dateAdded;

  Product(
      {@required this.name,
      @required this.description,
      @required this.price,
      @required this.model,
      @required this.imagesList,
      @required this.dateAdded});

  Product.fromData(Map<String, dynamic> data)
      : name = data['name'],
        description = data['description'],
        price = data['price'].toDouble(),
        imagesList = data['imagesList'],
        dateAdded = data['dateAdded'],
        model = data['model'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'model': model,
      'price': price,
      'imagesList': imagesList,
      'dateAdded': dateAdded,
    };
  }
}
