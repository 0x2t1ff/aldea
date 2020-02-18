import '../locator.dart';
import '../constants/route_names.dart';
import '../services/authentication_service.dart';
import '../services/firestore_service.dart';
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

  void navigateLogin() {
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
    if (result is bool) {
      if (result) {
        var user = await _authenticationService.getCurrentUser();
        registerCurrentUser({
          'email': user.email,
          'photoUrl': user.photoUrl,
          'uid': user.uid,
          'phoneNumber': user.phoneNumber,
          'name': user.displayName,
          'bkdPic': null,
          'postsCount': 0,
          'vouchCount': 0,
          'communitiesCount': 0,
          'winCount': 0,
          'gender': null,
          'age': null,
          'address': null
        });
        setBusy(false);
        _navigationService.navigateTo(HomeViewRoute, true);
      } else {
        setBusy(false);
        await _dialogService.showDialog(
            title: 'Error',
            description:
                'Ha habido un error al intentar crear la cuenta. Por favor, intentelo de nuevo mas tarde.');
      }
    } else {
      setBusy(false);
      await _dialogService.showDialog(
        title: "Error",
        description: result,
      );
    }
  }
}
