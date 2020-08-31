import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageSelector {
  Future<File> selectPostImage() async {
    return await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 1080, maxHeight: 768);
  }

  Future<File> selectProfileImage() async {
    return await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 135, maxHeight: 135);
  }

  Future<File> selectBackgroundImage() async {
    return await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 1080, maxHeight: 672);
  }
   Future<File> selectChatImage() async {
     return await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 700 , maxHeight: 700);
   }
  Future<File> selectCameraImage() async {
    return await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 700 , maxHeight: 700);
  }
}
