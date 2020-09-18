import 'package:aldea/models/user_model.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class CommunityUsersAdminViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  bool showingDialog = false;
  User selectedUser;
  bool kicking = true;

  List<DocumentSnapshot> _documentSnapshots;
  List<DocumentSnapshot> get users => _documentSnapshots;

  Future fetchAllUsers(String uid) async {
    setBusy(true);
    var documents = await _firestoreService.getCommunityUsers(uid);
    if (documents != null) {
      _documentSnapshots = documents.documents;
    }
    notifyListeners();
  }

  void selectPromote(User user) {
    kicking = false;
    selectUser(user);
  }

  void selectKicking(User user) {
    kicking = true;
    selectUser(user);
  }

  void unselectDialog() {
    print("unselect Dialog");
    showingDialog = false;
    notifyListeners();
  }

  void selectUser(User user) {
    selectedUser = user;
    showingDialog = true;
    print("selected user");
    notifyListeners();
  }

  void kickUser(String uid, String communityId) async {
    _firestoreService.kickCommunityUser(communityId, uid);
    unselectDialog();
  }

  void modUser(String uid, String communityId) {
    _firestoreService.giveCommunityMod(communityId, uid);
    unselectDialog();
  }

  Future<bool> onWillPop() async {
    if (showingDialog) {
      unselectDialog();
      return false;
    } else {
      return true;
    }
  }
}
