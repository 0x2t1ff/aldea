import 'package:aldea/constants/route_names.dart';
import 'package:aldea/locator.dart';
import 'package:aldea/services/navigation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();

  Future initialise(String id) async {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
    );

    _fcm.getToken().then((token) {
      Firestore.instance
          .collection('users')
          .document(id)
          .updateData({'pushToken': token});
    }).catchError((err) {
      print(err.message.toString());
    });
  }

//TODO: make it navigate
  //void _serialiseAndNAvigate(Map<String, dynamic> message){
  //  var notificationData = message["data"];
  //  var view = notificationData['view'];

  //  if(view != null){
  //    if(view == 'chat'){
  //      _navigationService.navigateTo(ChatViewRoute, false);
  //    }
  //  }
  //}
}
