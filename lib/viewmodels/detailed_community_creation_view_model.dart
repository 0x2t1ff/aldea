import 'package:aldea/models/community.dart';
import 'package:aldea/models/community_creation_request.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/viewmodels/base_model.dart';

import '../locator.dart';

class DetailedCommunityCreationViewModel extends BaseModel {
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();

  Future denyRequest(String id) async {
    _firestoreService.denyCommunityCreation(id);
  }

  Future acceptRequest(CommunityCreationRequest request) async {
    var community = Community.fromData(request.toJson(), request.id);
    _firestoreService.createCommunity(community, request.id).then(
        (_) => _firestoreService.denyCommunityCreation(request.id));
  }

  void goBack(){
    _navigationService.pop();
  }
}
