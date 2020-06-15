import 'package:aldea/models/user_model.dart';

class CommunityRequest {
  final User user;
  final String message;
  final bool isFromFB;
  final String uid;
  CommunityRequest(this.user, this.message, this.isFromFB, this.uid);

  CommunityRequest.fromData(
    Map<dynamic, dynamic> data,
  )   : user = User.fromData(data['user']),
        message = data['text'],
        uid = data['uid'],
        isFromFB = data['isFromFB'];
}
