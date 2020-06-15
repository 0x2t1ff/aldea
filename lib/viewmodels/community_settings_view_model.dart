import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';

import '../locator.dart';
import 'base_model.dart';

class CommunitySettingsViewModel extends BaseModel {
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();
  Map<String, dynamic> rulesData;
  bool isPublic;
  bool isMarketplace;
  String rules;
  Future saveChanges(
      String rules, bool isMarketplace, bool isPublic, String communityId) {
    _firestoreService.updateCommunitySettings(
        rules, isMarketplace, isPublic, communityId);
  }

  void popWindow() {
    _navigationService.pop();
  }

  Future getData(String communityId) async {
    setBusy(true);
    rulesData = await _firestoreService.getSettings(communityId);
    print(rulesData.toString());
    isPublic = rulesData["isPublic"] == "true";
    isMarketplace = rulesData["isMarketplace"] == "true";
    rules = rulesData["rules"];
    setBusy(false);
  }
}
