import 'package:aldea/models/user_model.dart';

class CommunityRequest {
  final User user;
  final String message;
  final bool isFromFB;
  CommunityRequest(this.user, this.message, this.isFromFB);

  CommunityRequest.fromData(Map<dynamic, dynamic> data,)
      : user = User.fromData(data['user']),
        message = data['text'],
        isFromFB = data['isFromFB'];
}
