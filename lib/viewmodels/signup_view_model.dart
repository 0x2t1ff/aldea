import 'package:aldea/services/firestore_service.dart';

import '../locator.dart';
import '../constants/route_names.dart';
import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  String phoneNumber;

  void navigateLogin() {
    _navigationService.navigateTo(LoginViewRoute, true);
  }

  void onPhoneNumberChange(String phone) {
    phoneNumber = phone;
  }

  Future signUp({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    setBusy(true);
    var exists = await _firestoreService.phoneNumberExists(phoneNumber);
    if (exists) {
      setBusy(false);
      _dialogService.showDialog(
          title: "Error",
          description: "Ya existe un usuario con ese número de teléfono.");
    } else {
      _authenticationService.signUpPhoneNumber(
          phoneNumber, email, name, password, setBusy);
    }
  }
}
