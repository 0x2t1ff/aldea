import 'dart:io';

import 'package:aldea/models/cloud_storage_result.dart';
import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/web_firebase_service.dart';
import 'package:aldea/utils/image_selector.dart';
import 'package:firebase/firebase.dart';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class ChatsViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final WebRTDBService _firestoreService = locator<WebRTDBService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  Stream<QueryEvent> _chatStream;
  Stream<QueryEvent> get messages => _chatStream;
  // ignore: avoid_init_to_null
  File selectedImage = null;

  Future<File> selectMessageImage() async {
    var tempImage = await _imageSelector.selectImage();
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
        isImage: isImage);
  }

  Future getMessages(String chatId) async {
    setBusy(true);
    var chatStream = _firestoreService.fetchChatMessages(chatId);
    chatStream.listen((event) {
      print(event.toString());
    });
    setBusy(true);

    if (chatStream is Stream<QueryEvent>) {
      _chatStream = chatStream;
      notifyListeners();
    } else {
      //print(_quickstrikes.length.toString());
      await _dialogService.showDialog(
        title: 'La actualizacion de mensajes ha fallado',
        description: "ha fallado XD asi al menos no crashea ",
      );
    }
  }
}
