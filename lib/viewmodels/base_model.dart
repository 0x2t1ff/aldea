import 'package:flutter/widgets.dart';
import '../locator.dart';
import '../models/user_model.dart';

class BaseModel extends ChangeNotifier {
  User get currentUser {
    return locator<User>();
  }

  String get currentLanguage {
    return currentUser.language;
  }

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
