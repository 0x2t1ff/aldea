import 'package:aldea/models/user_model.dart';
import 'package:aldea/constants/route_names.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class VouchViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  List<User> _vouches;
  List<User> get posts => _vouches;

  Future fetchPosts(String uid) async {
    setBusy(true);
    List vouches = await _firestoreService.getVouch(uid);
    setBusy(true);
    if (vouches is List<User> || vouches is User) {
      _vouches = vouches;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'La actualizacion de vouches ha fallado',
        description: "ha fallado XD asi al menos no crashea ",
      );
    }
  }

  void goToProfile(String id) {
    _navigationService.navigateTo(OtherProfileViewRoute, false, arguments: id);
  }
}
