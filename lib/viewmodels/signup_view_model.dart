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


  void navigateLogin(){
    _navigationService.navigateTo(LoginViewRoute, true);
  }

  Future signUp({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);
    var result = await _authenticationService.signupWithEmail(
      email: email,
      password: password,
    );
    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute, true);
      } else {
        await _dialogService.showDialog(
          title: 'Error',
          description: 'Ha habido un error al intentar crear la cuenta. Por favor, intentelo de nuevo mas tarde.'
        );
      }
    } else {
      await _dialogService.showDialog(
        title: "Error",
        description: result,
      );
    }
  }
}
