import 'package:aldea/locator.dart';
import 'package:aldea/models/community_request.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/viewmodels/base_model.dart';

class RequestsViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final Map arguments;
  List<CommunityRequest> requests = [];
  String communityId;

  RequestsViewModel(this.arguments);

  void setArguments() {
    requests = arguments["requests"];
    communityId = arguments["uid"];
  }

  Future removeRequest(String uid, int index) {
    _firestoreService.removeRequest(communityId, uid);
    requests.removeAt(index);
    _firestoreService.removeRequestUser(communityId, uid);
    notifyListeners();
  }

  Future acceptRequest(String uid, int index) async {
     await _firestoreService.removeRequestUser(communityId, uid);
    await _firestoreService
        .addCommunityFromRequest(uid, communityId)
        .then((value) => _firestoreService.addActivityFromRequest(communityId));

   
    await _firestoreService.removeRequest(communityId, uid);

    requests.removeAt(index);
    notifyListeners();
  }
}
