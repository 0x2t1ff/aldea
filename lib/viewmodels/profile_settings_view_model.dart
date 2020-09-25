import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/services/authentication_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/ui/views/login_view.dart';

import '../locator.dart';
import 'base_model.dart';
import "../services/navigation_service.dart";

class ProfileSettingsViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  Future goCreateCommunityScreen() {
    _navigationService.navigateTo(CommunityCreationViewRoute, false);
  }

  Future goAdminScreen() {
    _navigationService.navigateTo(AdminScreenViewRoute, true);
  }

  Future logOut() async {
    await _authenticationService.logOut();
    locator.unregister(instance: locator<User>());
    await _navigationService.navigateTo(LoginViewRoute, true, isRemoval: true);
  }

  void changeNotifications(bool notifications, String id) {
    _firestoreService.changeNotificationsSetting(id, notifications);
    notifyListeners();
  }

  void goToPrivacity() {
    _navigationService.navigateTo(PrivacidadViewRoute, false);
  }
}
