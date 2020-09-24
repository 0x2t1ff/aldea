import 'dart:io';

import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/user_post_model.dart';
import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/utils/image_selector.dart';
import "../constants/route_names.dart";
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class UserPostsViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  List<UserPostModel> _posts;
  List<UserPostModel> get posts => _posts;
  File firstImage;
  File secondImage;
  File thirdImage;

  Future fetchPosts(String uid) async {
    setBusy(true);
    var userPosts = await _firestoreService.getUserPosts(uid);
   

    setBusy(true);
    if (userPosts is List<UserPostModel>) {
      _posts = userPosts;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'La actualizacion de posts ha fallado',
        description: "ha fallado XD asi al menos no crashea ",
      );
    }
  }

  void navigate(String uid) {
    if (uid == currentUser.uid) {
    } else {
      _navigationService.navigateTo(OtherProfileViewRoute, false,
          arguments: uid);
    }
  }

  void deletePost(String postId, String communityId) {
    _firestoreService.deleteUserCommunityPosts(postId, communityId);
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

  Future selectFirstImage() async {
    var tempImage = await _imageSelector.selectPostImage();
    if (tempImage != null) {
      firstImage = tempImage;
      notifyListeners();
    }
  }

  Future selectSecondImage() async {
    var tempImage = await _imageSelector.selectPostImage();
    if (tempImage != null) {
      secondImage = tempImage;
      notifyListeners();
    }
  }

  Future selectThirdImage() async {
    var tempImage = await _imageSelector.selectPostImage();
    if (tempImage != null) {
      thirdImage = tempImage;
      notifyListeners();
    }
  }

  Future uploadImages(String communityId) async {
    List urls = [];
    await _cloudStorageService
        .uploadUserPostsImages(
            firstImage: firstImage,
            communityId: communityId,
            secondImage: secondImage,
            thirdImage: thirdImage)
        .then((value) => urls = value);
    return urls;
  }

  Future postCreation(String communityId, String description) async {
    var urlList = await uploadImages(communityId);
    _firestoreService.createUserPost(communityId, urlList, description,
        currentUser.picUrl, currentUser.name, currentUser.uid, DateTime.now());
  }

  void goToComments(String postId, String communityId) async {
    Map mapArgument = ({"postId": postId, "communityId": communityId});

    _navigationService.navigateTo(CommentsViewRoute, false,
        arguments: mapArgument);
  }
}
