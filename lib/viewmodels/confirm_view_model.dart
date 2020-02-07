import 'package:firebase_auth/firebase_auth.dart';

import '../locator.dart';
import '../constants/route_names.dart';
import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class ConfirmNumberViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  var isCodeSent = false;

  Future enviarVerificacion({@required String phoneNumber}) async {
    setBusy(true);
    await _authenticationService.verifyPhone(
      phoneNumber: phoneNumber,
      codeSent: codeSent,
      verifactionCompleted: verificationCompleted
    );
    setBusy(false);
  }

  void codeSent(String verificationId) {
    isCodeSent = true;
  }

  void verificationCompleted(AuthCredential credential) async {
    setBusy(true);
    var result = await _authenticationService.verificationCompleted(credential);
    setBusy(false);
    if (result is bool) {
      if (result) {
        //do something
        _navigationService.navigateTo(HomeViewRoute, true);
      } else {
        _dialogService.showDialog(
            title: "Error",
            description:
                "Un error ha ocurrido al intentar asociar el numero a la cuenta. Por favor intentelo de nuevo mas tarde.");
      }
    }
  }
}
