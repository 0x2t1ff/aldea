import 'package:aldea/services/firestore_service.dart';
import '../locator.dart';
import '../constants/route_names.dart';
import '../services/authentication_service.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  String _phoneNumber;
  void navigateRegister() {
    _navigationService.navigateTo(SignUpViewRoute, false);
  }

  Future login() async {
    setBusy(true);
    _authenticationService.loginPhoneNumber(_phoneNumber);
  }

  onPhoneNumberChange(String internationalPhone) {
    _phoneNumber = internationalPhone;
  }
}
