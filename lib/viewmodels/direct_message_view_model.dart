import 'dart:async';

import 'package:aldea/constants/route_names.dart';
import 'package:aldea/models/chat_room_model.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/services/rtdb_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class DirectMessageViewModel extends BaseModel {
  Stream<QuerySnapshot> chatsStream;
  List<ChatRoomModel> chatRooms;
  int limit = 0;
  RefreshController refreshController = RefreshController();

  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void openChat(String c) {
    _navigationService.navigateTo(ChatViewRoute, false, arguments: c);
  }

  void setChatRooms(List<DocumentSnapshot> docs) {
    chatRooms = docs.map((e) => ChatRoomModel.fromMap(e.data)).toList();
  }

  void loadMore() {}

  void getChatsStream() {
    limit += 8;
    chatsStream = _firestoreService.getChats(currentUser.uid, limit);
    notifyListeners();
  }

  Future<bool> onWillPop() async {
    var response = await _dialogService.showConfirmationDialog(
        description: "",
        confirmationTitle: "Si",
        cancelTitle: "No",
        title: "¿Estas seguro que quieres salir de la app?");
    return response.confirmed;
  }
}
