import 'dart:io';

import 'package:aldea/models/cloud_storage_result.dart';
import 'package:aldea/services/cloud_storage_service.dart';
import 'package:aldea/services/rtdb_service.dart';
import 'package:aldea/utils/image_selector.dart';
import 'package:firebase_database/firebase_database.dart';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class CommunityChatViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final RtdbService _firestoreService = locator<RtdbService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  Stream<Event> _chatStream;
  Stream<Event> get messages => _chatStream;
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
      print(event.toString());
    });
    setBusy(true);

    if (chatStream is Stream<Event>) {
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
