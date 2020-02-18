import 'package:aldea/services/authentication_service.dart';
import 'package:flutter/widgets.dart';
import "../locator.dart";

class BaseModel extends ChangeNotifier {
final AuthenticationService _authenticationService = locator<AuthenticationService>();

 currentUserId() =>   _authenticationService.getUserID();

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}