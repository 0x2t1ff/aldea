import 'package:aldea/constants/route_names.dart';
import 'package:aldea/services/authentication_service.dart';
import 'package:aldea/ui/views/login_view.dart';

import '../locator.dart';
import 'base_model.dart';
import "../services/navigation_service.dart";

class ProfileSettingsViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  Future goCreateCommunityScreen() {
    _navigationService.navigateTo(CommunityCreationViewRoute, false);
  }

  Future goAdminScreen() {
    _navigationService.navigateTo(AdminScreenViewRoute, true);
  }

  Future logOut() {
    _navigationService.navigateTo(LoginViewRoute, true);
    _authenticationService.logOut();
  }
  
}
