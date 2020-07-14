import 'dart:async';

import 'package:aldea/constants/route_names.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/services/rtdb_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class DirectMessageViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final RtdbService _rtdbService = locator<RtdbService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  List chatRooms;
  var chatStreams;
  List<Stream<Event>> _chatStream;
  List<Stream<Event>> get stream => _chatStream;

  void openChat(String c) {
    _navigationService.navigateTo(ChatViewRoute, false, arguments: c);
  }

  Future getStream() async {
    var stream = _firestoreService.getChats(currentUser.uid);

    stream.listen((event) async {
      chatRooms = event.data["chatRooms"];
      print(chatRooms.toString());
      chatStreams = _rtdbService.getChats(chatRooms);
      chatStreams[0].listen((event) {
        print(event.snapshot.value.toString() + "porfadsxafsd");
      });
      if (chatStreams is List<Stream<Event>>) {
        _chatStream = chatStreams;
        notifyListeners();
      } else {
        //print(_quickstrikes.length.toString());
        await _dialogService.showDialog(
          title: 'La actualizacion de chats ha fallado',
          description: "ha fallado XD asi al menos no crashea ",
        );
      }
    });
  }
}
