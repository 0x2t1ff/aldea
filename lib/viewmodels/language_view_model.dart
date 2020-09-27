import 'package:aldea/services/authentication_service.dart';
import 'package:aldea/services/firestore_service.dart';

import '../locator.dart';
import 'base_model.dart';

class LanguageViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  String selectedLanguage;
  //Yes I am hardcoding everything , we're just short on time and 2 options...cba, sorry if this is another unfortunate developer
  void getLanguage() {
    selectedLanguage = currentUser.language;
    notifyListeners();
  }

  changeLanguage(String language) {
    selectedLanguage = language;
    notifyListeners();
  }

  void changeUserLanguage(String language) {
    currentUser.language = language;
    _firestoreService.changeUserLanguage(language, currentUser.uid);
    notifyListeners();
  }
}
