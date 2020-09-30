import 'dart:async';
import 'dart:io';

import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/cloud_storage_result.dart';
import 'package:aldea/models/message_model.dart';
import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/utils/image_selector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../locator.dart';
import "../models/chat_room_model.dart";
import 'base_model.dart';

class ChatsViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  File selectedImage;
  bool isLoadingMore = false;
  bool isFirstLoad = true;
  List messageList = [];
  List get messages => messageList.reversed.toList();
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  ChatRoomModel chatRoomModel;
  String otherId;

  Future<void> addRequestOldMessages(String cid) async {
    var result = await _firestoreService.getOlderChatMessages(
        cid, messages.first.createdAt);
    messageList.addAll(
        result.documents.map((e) => MessageModel.fromMap(e.data)).toList());
    notifyListeners();
  }

  Future<void> loadChatRoom(String chatRoomId) async {
    var result = await _firestoreService.getChatRoom(chatRoomId);
    chatRoomModel = ChatRoomModel.fromMap(result.data);
    var temp = chatRoomModel.users;
    temp.remove(currentUser.uid);
    otherId = temp[0];
  }



  void addMessages(List<DocumentSnapshot> docs) {
    if (messageList.isEmpty) {
      messageList = docs.map((e) => MessageModel.fromMap(e.data)).toList();
    } else {
      messageList.insertAll(
          0,
          docs.map((e) {
            var message = MessageModel.fromMap(e.data);
            if (message != null &&
                !messageList.any((el) => el.createdAt == message.createdAt)) {
              return message;
            }
          }).toList()
            ..removeWhere((element) => element == null));
    }
  }

  Stream<QuerySnapshot> getChatStream(String chatRoomId) {
    return _firestoreService.getChatMessages(chatRoomId);
  }

  Future<File> selectMessageImage() async {
    var tempImage = await _imageSelector.selectChatImage();
    if (tempImage != null) {
      selectedImage = tempImage;
      notifyListeners();
      return tempImage;
    }
  }
  void notifyyes(){
    notifyListeners();
  }

  Future<File> selectCameraImage() async {
    var tempImage = await _imageSelector.selectCameraImage();
    if (tempImage != null) {
      selectedImage = tempImage;
      notifyListeners();
      return tempImage;
    }
  }

  Future<String> uploadImage({String chatId, File image}) async {
    CloudStorageResult imageResult;

    if (await image.exists()) {
      imageResult = await _cloudStorageService.uploadMessageImage(
          imageToUpload: image, chatId: chatId, userId: currentUser.uid);
      return imageResult.imageUrl;
    }
  }

  Future sendMessage(String text, String senderId, String chatRoomId,
      String username, String imageUrl, bool isImage) async {
    await _firestoreService.sendMessage(
      message: text,
      senderId: senderId,
      chatRoomId: chatRoomId,
      username: username,
      imageUrl: imageUrl,
      isImage: isImage,
      otherId: otherId
    );
    await scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 250), curve: Curves.linear);
  }

  void openHeroView(List url) {
    _navigationService.navigateTo(HeroScreenRoute, false, arguments: url);
  }

  void navigateToUser(String id) async {
    _navigationService.navigateTo(OtherProfileViewRoute, false, arguments: id);
  }

  Future<void> scrollDown() async {
    Timer(
        Duration(milliseconds: 0),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));

    isFirstLoad = false;
  }
}
