import 'package:aldea/ui/shared/google_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  final _codeController = TextEditingController();
  var isCodeSent = false;
  var phoneError;
  String phoneNumber;
  String phoneIsoCode;

  Future createPhoneAuth(BuildContext ctx) async {
    await _authenticationService.phoneAuth(
        phoneNumber, (verificationId) => codeSent(verificationId));
    return;
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(internationalizedPhoneNumber);
    print(isoCode);

    phoneNumber = internationalizedPhoneNumber;
    phoneIsoCode = isoCode;
  }

  void codeSent(String verificationId, [int forceResendingToken]) {
    print("yey");
    _dialogService
        .showPhoneCodeDialog(title: "Codigo de verificacion")
        .then((value) {
      print("verificatinId: " + verificationId);
      var _credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: _codeController.text.trim());
      print(_credential);
      _authenticationService.linkCredentials(_credential).then((response) {
        print("we check");
        if (response is User) {
          _navigationService.pop();
          _navigationService.navigateTo(HomeViewRoute, true);
        } else {
          print("gave error:");
          print(response.toString());
        }
      }).catchError((e) {
        phoneError = e;
        print(e.toString());
        _navigationService.pop();
        notifyListeners();
      });
    });
  }
}
