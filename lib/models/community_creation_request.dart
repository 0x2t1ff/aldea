import 'package:aldea/models/user_model.dart';

class CommunityCreationRequest {
  final User user;
  final String messageRequest;
  final String iconPicUrl;
  final String bkdPicUrl;
  final String name;
  final String description;
  final String communityRules;
  final String id;
  CommunityCreationRequest(this.id, this.user, this.messageRequest, this.name,
      this.bkdPicUrl, this.communityRules, this.description, this.iconPicUrl);

  CommunityCreationRequest.fromData(
    Map<dynamic, dynamic> data,
  )   : user = User.fromData(data['user']),
        id = data['id'],
        messageRequest = data['messageRequest'],
        bkdPicUrl = data['bkdPicUrl'],
        communityRules = data['communityRules'],
        description = data['description'],
        name = data['name'],
        iconPicUrl = data['iconPicUrl'];
//usado para pasar de request a comunidad, de ahi los campos no definidos en esta clase
  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'name': name,
      'description': description,
      'rules': communityRules,
      'iconPicUrl': iconPicUrl,
      'bkdPicUrl': bkdPicUrl,
      'postsCount': 0,
      'followerCount': 0,
      'moderators': [user.uid]
    };
  }
}
