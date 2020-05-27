import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/cloud_storage_result.dart';
import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/ui/views/vouch_view.dart';
import 'base_model.dart';
import 'dart:io';
import '../utils/image_selector.dart';
import '../locator.dart';

class ProfileViewModel extends BaseModel {
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  File selectedProfileImage;
  File selectedBkdImage;

  Future seeVouches() {
   _navigationService.navigateTo(VouchViewRoute, false);

  }

  Future selectProfileImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      selectedProfileImage = tempImage;
      notifyListeners();
    }
  }

  Future selectBkdImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      selectedBkdImage = tempImage;
      notifyListeners();
    }
  }

  var isShowingInfo = false;
  var _isEditting = false;

  bool get isEditting {
    return _isEditting;
  }

  void editProfile() {
    _isEditting = true;
    notifyListeners();
  }

  void cancelChanges() {
    selectedProfileImage = null;
    selectedBkdImage = null;
    _isEditting = false;
    notifyListeners();
  }

  Future saveChanges(
      {String email, String phoneNumber, String gender, String address}) async {
    setBusy(true);
    CloudStorageResult profileResult;
    CloudStorageResult bkdResult;

    if (selectedProfileImage != null) {
      profileResult = await _cloudStorageService.uploadUserImage(
          imageToUpload: selectedProfileImage,
          title: "profilePic",
          userId: currentUser.uid);
    }
    if (selectedBkdImage != null) {
      bkdResult = await _cloudStorageService.uploadUserImage(
          imageToUpload: selectedBkdImage,
          title: "bkdPic",
          userId: currentUser.uid);
    }

    await _firestoreService.updateUser(
        uid: currentUser.uid,
        picUrl:
            profileResult != null ? profileResult.imageUrl : currentUser.picUrl,
        picName: profileResult != null
            ? profileResult.imageFileName
            : currentUser.picName,
        bkdPicUrl:
            bkdResult != null ? bkdResult.imageUrl : currentUser.bkdPicUrl,
        bkdPicName: bkdResult != null
            ? bkdResult.imageFileName
            : currentUser.bkdPicName,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender,
        address: address);

    if (profileResult != null) {
      currentUser.picUrl = profileResult.imageUrl;
      currentUser.picName = profileResult.imageFileName;
    }

    if (bkdResult != null) {
      currentUser.bkdPicName = bkdResult.imageFileName;
      currentUser.bkdPicUrl = bkdResult.imageUrl;
    }
    currentUser.email = email;
    currentUser.phoneNumber = phoneNumber;
    currentUser.address = address;
    currentUser.gender = gender;
    _isEditting = false;
    selectedBkdImage = null;
    selectedProfileImage = null;
    setBusy(false);
  }

  void toggleInfo() {
    isShowingInfo = !isShowingInfo;
    notifyListeners();
  }
}
