import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../models/cloud_storage_result.dart';

class CloudStorageService {




Future<CloudStorageResult> uploadCommunityMessageImage({
  
  @required File imageToUpload,
  @required String communityId, 
  @required String userId
}) async  {
  
String imageFileName = DateTime.now().toString();
final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("/communitiesChatrooms/$communityId/$imageFileName");
StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
          imageFileName: "/communitiesChatrooms/$communityId/$imageFileName/", imageUrl: url);
    }
    return null;


}


Future<CloudStorageResult> uploadMessageImage({
  
  @required File imageToUpload,
  @required String chatId, 
  @required String userId
}) async  {
  
String imageFileName = DateTime.now().toString();
final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child("/chatrooms/$chatId/$imageFileName");
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



  Future<CloudStorageResult> uploadUserImage({
    @required File imageToUpload,
    @required String title,
    @required String userId,
  }) async {
    var imageFileName =

        title;
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child("/users/$userId/profile/$imageFileName");

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
          imageFileName: "/users/$userId/profile/$imageFileName", imageUrl: url);
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
