import 'base_model.dart';

import '../locator.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';

class ProfileViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final User _user = locator<User>();

  String getUserName() {
    return _user.name;
  }

  String getUserCommunitiesCount(){
    return _user.communitiesCount.toString();
  }

  String getUserPostsCount(){
    return _user.postsCount.toString();
  }

  String getUserWinsCount(){
    return _user.winCount.toString();
  }

  String getUserVouchCount(){
    return _user.vouchCount.toString();
  }

  String getUserProfilePicUrl(){
    return _user.picUrl;
  }

  String getUserBkdPicUrl(){
    return _user.bkdPicUrl;
  }
}
