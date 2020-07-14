import 'package:aldea/models/community.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/services/firestore_service.dart';

import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class CommunityProfileViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<Community> _communities;
  List<Community> get posts => _communities;

  Future fetchPosts(String uid) async {
    setBusy(true);
    var communities = await _firestoreService.getCommunitiesList(uid);
    setBusy(true);
    print(communities);
    if (communities is List<Community> || communities is Community) {
      _communities = communities;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'La actualizacion de vouches ha fallado',
        description: "ha fallado XD asi al menos no crashea ",
      );
    }
  }
}
