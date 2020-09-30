import 'dart:async';
import 'dart:io';

import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/cloud_storage_result.dart';
import 'package:aldea/models/message_model.dart';
import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/services/rtdb_service.dart';
import 'package:aldea/utils/image_selector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class CommunityChatViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final RtdbService _rtdbService = locator<RtdbService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;
  bool isFirstLoad = true;
  List<MessageModel> messageList = [];
  List<MessageModel> get messages => messageList.reversed.toList();
  File selectedImage;

  Future<File> selectMessageImage() async {
    var tempImage = await _imageSelector.selectChatImage();
    if (tempImage != null) {
      selectedImage = tempImage;
      notifyListeners();
      return tempImage;
    }
  }

  Stream<QuerySnapshot> getChatStream(String cid) =>
      _firestoreService.getCommunityChat(cid);

  Future<String> uploadImage({String communityId, File image}) async {
    CloudStorageResult imageResult;

    if (await image.exists()) {
      imageResult = await _cloudStorageService.uploadMessageImage(
          imageToUpload: image, chatId: communityId, userId: currentUser.uid);
      return imageResult.imageUrl;
    }
  }

//
  Future sendCommunityMessage(String text, String senderId, String communityId,
      String username, String imageUrl, bool isImage) async {
    await _firestoreService.sendCommunityMessage(
        message: text,
        senderId: senderId,
        communityId: communityId,
        username: username,
        imageUrl: imageUrl,
        isImage: isImage);

    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 250), curve: Curves.linear);
  }

  Future<void> addRequestOldMessages(String cid) async {
    var result = await _firestoreService.getCommunityMessages(
        cid, messages.first.createdAt);
    messageList
        .addAll(result.documents.map((e) => MessageModel.fromMap(e.data)));
    notifyListeners();
  }

  void addMessages(List<DocumentSnapshot> docs) {
    if (messageList.isEmpty) {
      messageList = docs.map((e) => MessageModel.fromMap(e.data)).toList();
    } else {
      messageList.insertAll(
          0,
          docs.map((e) {
            var message = MessageModel.fromMap(e.data);
            print(message.createdAt);
            if (message != null &&
                !messageList.any((el) => el.createdAt == message.createdAt)) {
              return message;
            }
          }).toList()
            ..removeWhere((element) => element == null));
    }

    print(messageList);
  }

  void openHeroView(List url) {
    _navigationService.navigateTo(HeroScreenRoute, false, arguments: url);
  }

  Future<void> scrollDown() async {
    Timer(
        Duration(milliseconds: 0),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));

    isFirstLoad = false;
  }
}
