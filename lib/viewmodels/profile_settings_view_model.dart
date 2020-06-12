import 'package:aldea/constants/route_names.dart';

import '../locator.dart';
import 'base_model.dart';
import "../services/navigation_service.dart";


class ProfileSettingsViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future goCreateCommunityScreen(){
    _navigationService.navigateTo(CommunityCreationViewRoute,false);
  }

  Future goAdminScreen(){
    _navigationService.navigateTo(AdminScreenViewRoute, true);

  }
  
}
