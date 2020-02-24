import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../models/cloud_storage_result.dart';

class CloudStorageService {
  Future<CloudStorageResult> uploadUserImage({
    @required File imageToUpload,
    @required String title,
    @required String userId,
  }) async {
    var imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();
    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("/$userId/profile/$imageFileName");

    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
          imageFileName: "/$userId/profile/$imageFileName", imageUrl: url);
    }
    return null;
  }
}
