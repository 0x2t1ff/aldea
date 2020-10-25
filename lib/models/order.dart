import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Order {
  final String userId;
  final List<dynamic> products;
  final double totalPrice;
  final Timestamp creationDate;
  final bool pending;

  const Order(
      {@required this.userId,
      @required this.products,
      @required this.totalPrice,
      @required this.creationDate,
      @required this.pending,
      });

  Order.fromData(Map<String, dynamic> data)
      : userId = data['userId'],
        products = data['products'],
        totalPrice = data['totalPrice'].toDouble(),
        creationDate = data['creationDate'],
        pending = data['pending'];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'products': products,
      'totalPrice': totalPrice,
      'pending': pending,
      'creationDate': creationDate
    };
  }

}
