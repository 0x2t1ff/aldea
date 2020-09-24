import 'package:flutter/foundation.dart';

class DialogRequest {
  final String title;
  final String description;
  final String buttonTitle;
  final String cancelTitle;
  final bool hasTextArea;
  final bool hasPhoneCode;

  DialogRequest(
      {@required this.title,
      @required this.description,
      @required this.buttonTitle,
      this.hasTextArea = false,
      this.hasPhoneCode = false,
      this.cancelTitle});
}

class DialogResponse {
  final String fieldOne;
  final String fieldTwo;
  final String textField;
  final bool confirmed;

  DialogResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
    this.textField,
  });
}
