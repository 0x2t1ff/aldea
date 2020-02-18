import 'package:aldea/services/dialog_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/viewmodels/base_model.dart';
import "../locator.dart";
import "../services/navigation_service.dart";
import "package:flutter/foundation.dart";
import "../models/quickstrike_model.dart";

class CreateQuickstrikeViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future addPost(
      {@required String title,
      double price,
      bool isLista,
      bool isRandom,
      bool isGame,
      String description,
      String modelo}) async {
    setBusy(true);
    var result = await _firestoreService.addPost(QuickStrikePost(
        title: title,
        userId: currentUserId(),
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
        description: "Tu pos ha sido creado",
      );
    }
    //maybe se necesita para volver atras
    //_navigationService.pop();
  }
}
