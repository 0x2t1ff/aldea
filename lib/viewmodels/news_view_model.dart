import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/community.dart';
import 'package:aldea/models/post_model.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';

import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class NewsViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<PostModel> _posts;
  List<PostModel> get posts => _posts;
  int limit = 10;
  bool isLoadingMore = false;
  Future fetchPosts(String uid) async {
    setBusy(true);
    var quickstrikeResults = await _firestoreService.getNewsPosts(uid, limit);
    limit += 10;

    setBusy(true);
    if (quickstrikeResults is List<PostModel>) {
      _posts = quickstrikeResults;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'La actualizacion de posts ha fallado',
        description: "ha fallado XD asi al menos no crashea ",
      );
    }
  }

  Future<bool> likePost(
      String postId, bool liked, List<dynamic> likeList) async {
    bool likeBool;

    if (liked) {
      likeList.remove(currentUser.uid);
    } else {
      likeList.add(currentUser.uid);
    }
    await _firestoreService
        .likePost(likeList, postId, liked)
        .then((value) => likeBool = value);
    return likeBool;
  }

  void deletePost(String id, String cid) {
    _firestoreService.deletePost(id, cid);
  }

  bool isLiked(List likeList) {
    if (likeList.contains(currentUser.uid)) {
      return true;
    }
    return false;
  }

  void goToCommunity(Community c) {
    _navigationService.navigateTo(CommunityViewRoute, false, arguments: c);
  }

  void communityFromFeed(String id) async {
//no it dont do shit XD
  }
  void goToComments(String postId) {
    _navigationService.navigateTo(CommentsViewRoute, false,
        arguments: ({'postId': postId}));
  }

  void loadMorePosts(String uid) async {
    setIsLoading(true);
    await fetchPosts(uid);
    setIsLoading(false);
  }

  void setIsLoading(bool value) {
    isLoadingMore = value;
    notifyListeners();
  }
}
