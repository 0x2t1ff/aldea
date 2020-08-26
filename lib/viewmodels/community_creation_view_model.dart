import 'dart:io';
import 'package:aldea/locator.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/dialog_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/utils/image_selector.dart';

import 'base_model.dart';

class CommunityCreationViewModel extends BaseModel {
  ImageSelector _imageSelector = locator<ImageSelector>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  CloudStorageService _cloudStorageService = locator<CloudStorageService>();
  DialogService _dialogService = locator<DialogService>();
    final NavigationService _navigationService = locator<NavigationService>();


  File profilePic;
  File bkdPic;

  Future selectBkdImage() async {
    var tempImage = await _imageSelector.selectBackgroundImage();
    if (tempImage != null) {
      bkdPic = tempImage;
      notifyListeners();
    }
  }

  Future selectProfileImage() async {
    var tempImage = await _imageSelector.selectProfileImage();
    if (tempImage != null) {
      profilePic = tempImage;
      notifyListeners();
    }
  }

  Future createRequest(User user, String messageRequest, String name,
      String communityRules, String description) async {
        print("we got here");
    var reference = await _firestoreService.createRequestId();
    print(reference.documentID + " this is the reference");
    var profilePicUrl = await _cloudStorageService.uploadCommunityRequestImage(
        imageToUpload: profilePic, communityId: reference.documentID);
    var bkdPicUrl = await _cloudStorageService.uploadCommunityRequestImage(
        imageToUpload: bkdPic, communityId: reference.documentID);
    var sth = await _firestoreService.createCommunityCreationRequest(user, messageRequest,
        bkdPicUrl, name, communityRules, description, profilePicUrl, reference);
  }

  Future termsDialog(){
    _dialogService.showDialog(title:"" , buttonTitle: "Okay", description: "Please accept the terms and conditions");
  }

  Future fieldsDialog(){
    _dialogService.showDialog(title:"", buttonTitle: "okay" , description: " por favor rellena todos los campos");
  }

  Future backToSettings(){
    _navigationService.pop();
  }
}
