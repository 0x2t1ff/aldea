import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../models/cloud_storage_result.dart';

class CloudStorageService {
  Future<CloudStorageResult> uploadCommunityMessageImage(
      {@required File imageToUpload,
      @required String communityId,
      @required String userId}) async {
    String imageFileName = DateTime.now().toString();
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("/communitiesChatrooms/$communityId/$imageFileName");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
          imageFileName: "/communitiesChatrooms/$communityId/$imageFileName/",
          imageUrl: url);
    }
    return null;
  }

  Future<CloudStorageResult> uploadPostImages(
      File image, String communityId) async {
    String fileName = DateTime.now().toString();
    final StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("/communities/$communityId/posts/$fileName");
    StorageUploadTask uploadTask = ref.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;

    var downloadUrl = await snapshot.ref.getDownloadURL();
    if (uploadTask.isSuccessful) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
          imageFileName: "/communities/$communityId/posts/$fileName",
          imageUrl: url);
    }
    return null;
  }

  Future<List> uploadUserPostsImages(
      {File firstImage,
      @required String communityId,
      File secondImage,
      File thirdImage}) async {
    List urlsList = [];
    if (firstImage != null) {
      await uploadUserPostImage(
              imageToUpload: firstImage, communityId: communityId)
          .then((value) => urlsList.add(value));
    }
    if (secondImage != null) {
      await uploadUserPostImage(
              imageToUpload: secondImage, communityId: communityId)
          .then((value) => urlsList.add(value));
    }
    if (thirdImage != null) {
      await uploadUserPostImage(
              imageToUpload: secondImage, communityId: communityId)
          .then((value) => urlsList.add(value));
    }
    return urlsList;
  }

  Future<String> uploadCommunityRequestImage({
    @required File imageToUpload,
    @required String communityId,
  }) async {
    String imageFileName = DateTime.now().toString();
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("/communities/$communityId/$imageFileName");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    if (uploadTask.isSuccessful) {
      var url = downloadUrl.toString();
      return url;
    }
  }

  Future<String> uploadUserPostImage({
    @required File imageToUpload,
    @required String communityId,
  }) async {
    String imageFileName = DateTime.now().toString();
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("/communities/$communityId/$imageFileName");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return url;
    }
  }

  Future<CloudStorageResult> uploadMessageImage(
      {@required File imageToUpload,
      @required String chatId,
      @required String userId}) async {
    String imageFileName = DateTime.now().toString();
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("/chatrooms/$chatId/$imageFileName");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
          imageFileName: "/chatrooms/$chatId/$imageFileName/", imageUrl: url);
    }
    return null;
  }

  Future<CloudStorageResult> uploadQuickstrikmImages(
      File image, String communityId) async {
    String fileName = DateTime.now().toString();
    final StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("/communities/$communityId/quickstrikes/$fileName");
    StorageUploadTask uploadTask = ref.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;

    var downloadUrl = await snapshot.ref.getDownloadURL();
    if (uploadTask.isSuccessful) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
          imageFileName: "/communities/$communityId/quickstrikes/$fileName",
          imageUrl: url);
    }
    return null;
  }

  Future<CloudStorageResult> uploadUserImage({
    @required File imageToUpload,
    @required String title,
    @required String userId,
  }) async {
    var imageFileName = title;
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("/users/$userId/profile/$imageFileName");

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    if (uploadTask.isSuccessful) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
          imageFileName: "/users/$userId/profile/$imageFileName",
          imageUrl: url);
    }
    return null;
  }

  Future<CloudStorageResult> uploadPostImage({
    @required File imageToUpload,
    @required String postId,
    @required String title,
  }) async {
    var imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("/posts/$postId/$imageFileName");

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
          imageFileName: "/$postId/$imageFileName", imageUrl: url);
    }
    return null;
  }
}
