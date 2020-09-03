import 'dart:io';

import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/cloud_storage_result.dart';
import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/services/rtdb_service.dart';
import 'package:aldea/utils/image_selector.dart';
import 'package:firebase_database/firebase_database.dart';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class ChatsViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final RtdbService _firestoreService = locator<RtdbService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  Stream<Event> _chatStream;
  File selectedImage;
  int limit = 15;
  bool isLoadingMore = false;
  List messageList = [];
  List get messages => messageList;

  Future getMessages(String chatId) async {
    setBusy(true);
    var chatStream = _firestoreService.getChatMessages(chatId, limit);

    setBusy(true);

    if (chatStream is Stream<Event>) {
      _chatStream = chatStream;
      _chatStream.listen((event) {
        messageList.add(event.snapshot.value);
        notifyListeners();
      });
      
      notifyListeners();
    } else {
      
      await _dialogService.showDialog(
        title: 'La actualizacion de mensajes ha fallado',
        description: "ha fallado XD asi al menos no crashea ",
      );
    }
  }

  Future<File> selectMessageImage() async {
    var tempImage = await _imageSelector.selectChatImage();
    if (tempImage != null) {
      selectedImage = tempImage;
      notifyListeners();
      return tempImage;
    }
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
      String username, String imageUrl, bool isImage) {
    _firestoreService.sendMessage(
      message: text,
      senderId: senderId,
      chatRoomId: chatRoomId,
      username: username,
      imageUrl: imageUrl,
      isImage: isImage,
    );
  }

  void openHeroView(List url) {
    _navigationService.navigateTo(HeroScreenRoute, false, arguments: url);
  }

  void readMessage(chatRoomId) {
    _firestoreService.readMessage(chatRoomId, currentUser.uid);
  }

  void loadMoreMessages(String chatId) {
    isLoadingMore = true;
    
    limit += 15;
    getMessages(chatId);
    isLoadingMore = false;
  }
}
