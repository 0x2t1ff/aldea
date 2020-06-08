import 'package:aldea/services/dialog_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/viewmodels/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "../locator.dart";
import "package:flutter/foundation.dart";
import "../models/quickstrike_model.dart";

class CreateQuickstrikeViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  
  
}
