import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Vouch {
  final String id;

  Vouch({@required this.id});

  Map<String, dynamic> toMap() {
    return {'id': id, };
  }

  static Vouch fromMap(Map<String, dynamic> map) {
    return Vouch(id: map['id']);
  }
}
