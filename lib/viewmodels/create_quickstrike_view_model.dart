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

  Future addPost(
      {@required String title,
      double price,
      bool isLista,
      bool isRandom,
      bool isGame,
      String description,
      String modelo,
      Timestamp  fechaQuickstrike}) async {
    setBusy(true);
    var result = await _firestoreService.addPost(QuickStrikeModel(
      fechaQuickstrike: fechaQuickstrike,
        title: title,
        userId: currentUser.uid,
        description: description,
        modelo: modelo,
        isGame: isGame,
        isRandom: isRandom,
        isLista: isLista,
        price: price));
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(
          title: "No se ha podido crear el quickstrike", description: result);
    } else {
      await _dialogService.showDialog(
        title: "El quickstrike se ha creado correctamente",
        description: "Tu post ha sido creado",
      );
    }
    //maybe se necesita para volver atras
    //_navigationService.pop();
  }
}
