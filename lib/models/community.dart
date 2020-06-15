class Community {
  final String uid;
  final String name;
  final String description;
  final String rules;
  final String iconPicUrl;
  final String bkdPicUrl;
  final int postsCount;
  final int followerCount;
  final List<dynamic> moderators;
  final bool isPublic;
  final bool isMarketplace;

  Community(this.uid, this.rules,
      {this.name,
      this.description,
      this.iconPicUrl,
      this.bkdPicUrl,
      this.postsCount,
      this.followerCount,
      this.moderators,
      this.isMarketplace,
      this.isPublic});

  Community.fromData(Map<String, dynamic> data, String uid)
      : name = data['name'],
        uid = uid,
        description = data['description'],
        rules = data['rules'],
        iconPicUrl = data['iconPicUrl'],
        bkdPicUrl = data['bkdPicUrl'],
        postsCount = data['postsCount'],
        followerCount = data['followerCount'],
        isMarketplace = data['isMarketplace'],
        isPublic = data['isPublic'],
        moderators = data['moderators'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'rules': rules,
      'iconPicUrl': iconPicUrl,
      'bkdPicUrl': bkdPicUrl,
      'postsCount': postsCount,
      'followerCount': followerCount,
      'moderators': moderators,
      'isMarketplace': isMarketplace,
      'isPublic': isPublic,
    };
  }
}
