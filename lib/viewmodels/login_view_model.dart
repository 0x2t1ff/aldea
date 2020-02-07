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

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);
    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );
    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Error',
          description: 'Ha habido un error al intentar acceder la cuenta. Por favor, intentelo de nuevo mas tarde.'
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
