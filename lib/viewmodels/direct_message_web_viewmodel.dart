import 'dart:async';

import 'package:aldea/constants/route_names.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:aldea/services/web_firebase_service.dart';
import 'package:firebase/firebase.dart';
import 'base_model.dart';
import '../locator.dart';
import '../services/dialog_service.dart';

class DirectMessageWebViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final WebRTDBService _rtdbService = locator<WebRTDBService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  List chatRooms;
  var chatStreams;
  List<Stream<QueryEvent>> _chatStream;
  List<Stream<QueryEvent>> get stream => _chatStream;

  void openChat(String c) {
    _navigationService.navigateTo(ChatViewRoute, false, arguments: c);
  }

  Future getStream() async {
    var stream = _firestoreService.getChats(currentUser.uid);

    stream.listen((event) async {
      chatRooms = event.data["chatRooms"];
      print(chatRooms.toString() + "chatrooms to string yes ");
      chatStreams = _rtdbService.getChats(chatRooms);
      chatStreams[0].listen((event) {

      });
      if (chatStreams is List<Stream<QueryEvent>>) {
        print("the list was what it's supposed to be");
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
