import 'dart:convert';

import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/services/rtdb_service.dart';
import '../services/dialog_service.dart';
import 'base_model.dart';
import '../locator.dart';
import 'package:http/http.dart' as http;

class OtherProfileViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final RtdbService _rtdb = locator<RtdbService>();

  User user;
  User get userData => user;
  String targetUserId;
  String animationController = "Fijo Azul";
  bool isOpening = false;

  Future fetchUser(String uid) async {
    targetUserId = uid;
    setBusy(true);
    var _user = await _firestoreService.getUser(uid);

    if (_user is User) {
      user = _user;
      checkVouch();
      setBusy(false);
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'La actualizacion del usuario ha fallado',
        description: "ha fallado XD asi al menos no crashea ",
      );
    }
  }

  void seeVouches(String c) {
    _navigationService.navigateTo(VouchViewRoute, false, arguments: c);
  }

  void openExistingChat(String c) {
    _navigationService.navigateTo(ChatViewRoute, false, arguments: c);
  }

  void seeCommunities(String c) {
    _navigationService.navigateTo(CommunitiesProfileViewRoute, false,
        arguments: c);
  }

  Future openChat(String id) async {
    isOpening = true;
    notifyListeners();
    var result = await _firestoreService.getChat([currentUser.uid, user.uid]);
    if (result != null) {
      isOpening = false;
      notifyListeners();
      openExistingChat(result.documentID);
    } else {
      List userIds = [currentUser.uid, user.uid];
      List userImages = [currentUser.picUrl, user.picUrl];
      List username = [currentUser.name, user.name];
      var chatId =
          await _firestoreService.createChatRoom(userIds, userImages, username);
      isOpening = false;
      notifyListeners();
      openExistingChat(chatId);
    }
  }

  Future giveVouch() async {
    if (user.vouches.contains(currentUser.uid)) {
      animationController = "Fijo azul";
    } else {
      animationController = "Animacion";
      notifyListeners();
      Future.delayed(Duration(milliseconds: 300)).then((value) {
        animationController = "Fijo amarillo";
      });
    }

    List vouchList = await _firestoreService.getVouchList(user.uid);
    print("vouch function starting");
    if (vouchList.contains(currentUser.uid)) {
      vouchList.remove(currentUser.uid);
      _firestoreService.giveVouch(vouchList, user.uid);
      user.vouches = vouchList;
    } else {
      vouchList.add(currentUser.uid);
      _firestoreService.giveVouch(vouchList, user.uid);
      user.vouches = vouchList;
    }

    notifyListeners();
  }

  Future<void> banUser() async {
    http
        .post(
          'https://us-central1-aldea-dev-40685.cloudfunctions.net/banUser',
          body: JsonEncoder().convert(user.uid),
        )
        .then((value) async => {
              if (value.statusCode == 200)
                {
                  await _dialogService.showDialog(
                      title: 'Usuario baneado',
                      description:
                          'El usuario ' + user.name + ' ha sido baneado')
                }
              else
                {
                  await _dialogService.showDialog(
                      title: 'Error al banear usuario',
                      description:
                          'Algo ha ido mal al intentar banear al usuario ' +
                              user.name)
                }
            });
  }

  void checkVouch() {
    if (user.vouches.contains(currentUser.uid)) {
      animationController = "Fijo amarillo";
    } else {
      animationController = "Fijo azul";
    }
  }
}
