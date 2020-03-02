import 'package:aldea/locator.dart';
import 'package:aldea/models/community.dart';

import 'base_model.dart';
import '../services/firestore_service.dart';

class CommunitiesViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  final List<Map<String, dynamic>> topCommunities = List();

  final List<Community> communitiesList = List();

  Future fetchCommunities() async {
    setBusy(true);
    var topDocuemnt = await _firestoreService.getTopCommunities();
    var communities = await _firestoreService.getCommunities(); 
    communities.forEach((c) => communitiesList.add(Community.fromData(c.data)));
    var topList = topDocuemnt['topCommunities'];
    topCommunities.add(topList[0]);
    topCommunities.add(topList[1]);
    topCommunities.add(topList[2]);
    setBusy(false);
  }
}
