import './base_model.dart';
import '../locator.dart';
import '../constants/route_names.dart';
import '../services/authentication_service.dart';
import '../services/firestore_service.dart';
import '../services/navigation_service.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      var userUid = await _authenticationService.getUserUID();
      var userData = await _firestoreService.getUserData(userUid);
      registerCurrentUser(userData);
      _navigationService.navigateTo(HomeViewRoute, true);
    } else {
      _navigationService.navigateTo(LoginViewRoute, true);
    }
  }
}
