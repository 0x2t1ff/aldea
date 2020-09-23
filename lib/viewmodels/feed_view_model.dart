import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/community.dart';
import 'package:aldea/models/post_model.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'dart:async';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class FeedViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  final NavigationService _navigationService = locator<NavigationService>();

  List<PostModel> _posts;
  List<PostModel> get posts => _posts;
  bool refreshing = false;
  bool isLoadingMore = false;
  //make another get to retrieve from the feed-view,
  List<Community> get communities => communityList;
  List<Community> communityList;
  bool dialogShowing = false;

  void refreshingFeed() {
    refreshing = true;
    notifyListeners();
  }

  void refreshingFeedEnded() {
    refreshing = false;
    notifyListeners();
  }

  Future getPosts() async {
    setBusy(true);
    var posts = await _firestoreService.getPosts(currentUser.communities);
    _posts = posts;
    notifyListeners();
    print("acaba");
  }

  Future loadMorePosts() async {
    isLoadingMore = true;
    notifyListeners();
    var postsToAdd = await _firestoreService.getMorePosts(
        currentUser.communities, _posts[_posts.length - 1].fechaQuickstrike);

    _posts.addAll(postsToAdd);
    notifyListeners();
  }

  setIsLoading(bool val) {
    isLoadingMore = val;
    notifyListeners();
  }

  Future fetchPosts() async {
    setBusy(true);
    var communities = currentUser.communities;
    var quickstrikeResults = await _firestoreService.getPosts(communities);

    if (communities != null) {
      communityList = await _firestoreService.getCommunitiesData(
          communities, currentUser.uid);
      notifyListeners();
    }
    if (quickstrikeResults is List<PostModel>) {
      _posts = quickstrikeResults;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Error.',
        description:
            "Ha ocurrido un error al cargar las publicaciones. Por favor, inténtelo más tarde.",
      );
    }

    setBusy(false);
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

  bool isLiked(List likeList) {
    if (likeList.contains(currentUser.uid)) {
      return true;
    }
    return false;
  }

  void deletePost(String id, String cid) {
    _firestoreService.deletePost(id, cid);
  }

  void goToCommunity(Community c) {
    _navigationService.navigateTo(CommunityViewRoute, false, arguments: c);
  }

  void goToComments(String postId) {
    _navigationService.navigateTo(CommentsViewRoute, false,
        arguments: ({'postId': postId}));
  }

  void communityFromFeed(String id) async {
    var communityData = await _firestoreService.getCommunity(id);
    print(communityData);
    Community community = Community.fromData(communityData, id);
    goToCommunity(community);
  }

  Future<bool> onWillPop() async {
    if (dialogShowing == true) {
      dialogShowing = false;
    } else {
      dialogShowing = true;
      var response = await _dialogService.showConfirmationDialog(
          description: "",
          confirmationTitle: "Si",
          cancelTitle: "No",
          title: "¿Estas seguro que quieres salir de la app?");

      return response.confirmed;
    }
  }
}
