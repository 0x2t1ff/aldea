import 'dart:io';

import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/utils/image_selector.dart';

import '../locator.dart';
import 'base_model.dart';

class CommunitySettingsViewModel extends BaseModel {
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();
  ImageSelector _imageSelector = locator<ImageSelector>();
  CloudStorageService _cloudStorageService = locator<CloudStorageService>();
  Map<String, dynamic> rulesData;
  bool isPublic;
  bool isMarketplace;
  String rules;
  File profilePic;
  File bkdPic;


  Future saveChanges(String rules, bool isMarketplace, bool isPublic,
      String communityId, String description) {
        //TODO: pending testing , but won't be doing it in the psycho one
    _firestoreService.updateCommunitySettings(
        rules, isMarketplace, isPublic, communityId, description);
    _cloudStorageService.uploadCommunityImages(
        backgroundImage: bkdPic, profileImage: profilePic, id: communityId);
  }

  void popWindow() {
    _navigationService.pop();
  }

  Future selectBkdImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      bkdPic = tempImage;
      notifyListeners();
    }
  }

  Future selectProfileImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      profilePic = tempImage;
      notifyListeners();
    }
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
