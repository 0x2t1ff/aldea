import 'package:aldea/services/push_notification_service.dart';

import '../locator.dart';
import './base_model.dart';
import '../constants/route_names.dart';
import '../services/authentication_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      var userUid = await _authenticationService.getUserUID();
      var userData = await _firestoreService.getUserData(userUid);
      registerCurrentUser(userData);
      _navigationService.navigateTo(HomeViewRoute, true);

      await _pushNotificationService.initialise(currentUser.uid);
    } else {
      _navigationService.navigateTo(LoginViewRoute, true);
    }
  }
}
