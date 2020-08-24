import 'package:aldea/constants/route_names.dart';
import 'package:aldea/locator.dart';
import 'package:aldea/models/community.dart';
import 'package:aldea/services/dialog_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'base_model.dart';
import '../services/firestore_service.dart';

class CommunitiesViewModel extends BaseModel {
  int height = 0;

  final List<Community> communitiesList = List();
  bool isLoadingMore = false;
  bool isShowingMore = false;
  bool isSendingRequest = false;
  Community selectedCommunity;
  DocumentSnapshot lastDoc;
  final List<Map<String, dynamic>> topCommunities = List();

  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future fetchCommunities() async {
    setBusy(true);
    var topDocument = await _firestoreService.getTopCommunities();
    var communities = await _firestoreService.getFirstCommunities();
    communities.forEach((c) {
      lastDoc = c;
      communitiesList.add(Community.fromData(c.data, c.documentID));
    });
    var topList = topDocument;
    topCommunities.add(topList[0]);
    topCommunities.add(topList[1]);
    topCommunities.add(topList[2]);
    setBusy(false);
  }

  Future<Community> getTopCommunity(String id) async {
    Map<String, dynamic> queryData = await _firestoreService.getCommunity(id);
    var community = Community.fromData(queryData, id);
    return community;
  }

  void goToCommunity(Community c) {
    _navigationService.navigateTo(CommunityViewRoute, false, arguments: c);
  }

  Future requestCommunityAcces(Community c) async {
    var response = await _dialogService.showAccessRequestDialog(
        title: "Solicitud de acceso", description: "");
    if (response.confirmed) {
      isSendingRequest = true;
      notifyListeners();
      await _firestoreService.requestCommunityAccess(
          c.uid, currentUser, response.textField, false);
    }
    isSendingRequest = false;
    notifyListeners();
  }

  void loadMoreCommunities() async {
    print("loading more communities");
    isLoadingMore = true;
    notifyListeners();
    var docs = await _firestoreService.getMoreCommunities(lastDoc, limit: 15);
    docs.forEach((d) {
      lastDoc = d;
      communitiesList.add(Community.fromData(d.data, d.documentID));
    });
    isLoadingMore = false;
    notifyListeners();
  }

  void unselectCommunity() {
    selectedCommunity = null;
    height = 0;
    notifyListeners();
  }

  void selectCommunity(Community c) {
    selectedCommunity = c;
    height = 1;
    notifyListeners();
  }
}
