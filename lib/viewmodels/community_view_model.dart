import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/community_request.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/viewmodels/base_model.dart';

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
}
