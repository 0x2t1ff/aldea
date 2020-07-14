import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/services/rtdb_service.dart';
import '../services/dialog_service.dart';
import 'base_model.dart';
import '../locator.dart';

class OtherProfileViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RtdbService _rtdb = locator<RtdbService>();

  User user;
  User get userData => user;

  String targetUserId;

  Future fetchUser(String uid) async {
    targetUserId = uid;
    setBusy(true);
    var _user = await _firestoreService.getUser(uid);

    if (_user is User) {
      user = _user;
      print(_user.toString() + "should be instance of user but w.e XD");
      setBusy(false);
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'La actualizacion del usuario ha fallado',
        description: "ha fallado XD asi al menos no crashea ",
      );
    }
  }

  Future seeVouches(String c) {
    _navigationService.navigateTo(VouchViewRoute, false, arguments: c);
  }

  void openExistingChat(String c) {
    _navigationService.navigateTo(ChatViewRoute, false, arguments: c);
  }

  Future seeCommunities(String c) {
    _navigationService.navigateTo(CommunitiesProfileViewRoute, false,
        arguments: c);
  }

  Future openChat(String id) async {
    bool existsChat = false;
    currentUser.chatRooms.forEach((element) {
      if (user.chatRooms.contains(element)) {
        existsChat = true;
        openExistingChat(element);
      }
    });
    if (existsChat) {
      return;
    } else {
      print("ah y es this shouldnt happen");
      List userIds = [currentUser.uid, user.uid];
      List userImages = [currentUser.picUrl, user.picUrl];
      List username = [currentUser.name, user.name];
      var chatId = _rtdb.createChatRoom(userIds, userImages, username);
      _firestoreService.writeNewChatRoom(currentUser.uid, id, chatId);
      _firestoreService.writeNewChatRoom(id, currentUser.uid, chatId);
      openExistingChat(chatId);
    }
  }

  Future giveVouch() async {
    List vouchList = await _firestoreService.getVouchList(user.uid);
    if (vouchList.contains(currentUser.uid)) {
      vouchList.remove(currentUser.uid);
      await _firestoreService.giveVouch(vouchList, user.uid);
      user.vouches = vouchList;
    } else {
      vouchList.add(currentUser.uid);
      await _firestoreService.giveVouch(vouchList, user.uid);
      user.vouches = vouchList;
    }
    notifyListeners();
  }
}
