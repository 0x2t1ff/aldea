import 'dart:io';

import 'package:aldea/models/cloud_storage_result.dart';
import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/web_firebase_service.dart';
import 'package:aldea/utils/image_selector.dart';
import 'package:firebase/firebase.dart';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class CommunityChatWebViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final WebRTDBService _firestoreService = locator<WebRTDBService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  Stream<QueryEvent> _chatStream;
  Stream<QueryEvent> get messages => _chatStream;
  File selectedImage;

  Future<File> selectMessageImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      selectedImage = tempImage;
      notifyListeners();
      return tempImage;
    }
  }

//TODO later 
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
      String username, String imageUrl, bool isImage) {
    _firestoreService.sendCommunityMessage(
        message: text,
        senderId: senderId,
        communityId: communityId,
        username: username,
        imageUrl: imageUrl,
        isImage: isImage);
  }

  Future getMessages(String communityId) async {
    setBusy(true);
    var chatStream = _firestoreService.fetchCommunityChatMessages(communityId);
    chatStream.listen((event) {
      print(event.snapshot.exists().toString() + " value from the stream listened");
    });
    setBusy(true);

    if (chatStream is Stream<QueryEvent>) {
      _chatStream = chatStream;
      notifyListeners();
    } else {
      //print(_quickstrikes.length.toString());
      await _dialogService.showDialog(
        title: 'La actualizacion de mensajes ha fallado',
        description: "Error",
      );
    }
  }
}
