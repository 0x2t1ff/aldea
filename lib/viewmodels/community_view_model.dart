import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/community_request.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/viewmodels/base_model.dart';
import 'package:aldea/services/cloud_storage_service.dart';

import 'base_model.dart';
import 'dart:io';

import '../utils/image_selector.dart';
import '../locator.dart';

class CommunityViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<CommunityRequest> requests;

  Future getRequests(String communityId) async {
    setBusy(true);
    var data = await _firestoreService.getCommunityRequests(communityId);
    requests = data.map((doc) => CommunityRequest.fromData(doc.data)).toList();
    setBusy(false);
  }

  void goToRequests() {
    _navigationService.navigateTo(RequestsViewRoute, false, arguments: requests);
  }
  final ImageSelector _imageSelector = locator<ImageSelector>();


  File firstImage;
  File secondImage;
  File thirdImage;

  Future selectFirstImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      firstImage = tempImage;
      notifyListeners();
    }
  }

  Future selectSecondImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      secondImage = tempImage;
      notifyListeners();
    }
  }

  Future selectThirdImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      thirdImage = tempImage;
      notifyListeners();
    }
  }
    void cancelChanges() {
    firstImage = null;
    secondImage = null;
    thirdImage = null ;
    notifyListeners();
  }

  void uploadPost(){
    
  }

  void uploadQuickStrike(){
    
  }

}
