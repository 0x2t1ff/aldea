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
  String phoneNumber;

  void navigateLogin() {
    _navigationService.navigateTo(LoginViewRoute, true);
  }

  Future onPhoneNumberChange(String phone) {
    phoneNumber = phone;
  }

  Future signUp({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    setBusy(true);
    _authenticationService.signUpPhoneNumber(
        phoneNumber, email, name, password);

    // var result = await _authenticationService.signupWithEmail(
    //     email: email, password: password, name: name);
    // if (result is bool) {
    //   if (result) {
    //     setBusy(false);
    //     _navigationService.navigateTo(HomeViewRoute, true);
    //   } else {
    //     setBusy(false);
    //     await _dialogService.showDialog(
    //         title: 'Error',
    //         description:
    //             'Ha habido un error al intentar crear la cuenta. Por favor, intentelo de nuevo mas tarde.');
    //   }
    // } else {
    //   setBusy(false);
    //   await _dialogService.showDialog(
    //     title: "Error",
    //     description: result,
    //   );
    // }
  }
}
