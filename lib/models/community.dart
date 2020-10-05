class Community {
  String uid;
  String name;
  String description;
  String rules;
  String iconPicUrl;
  String bkdPicUrl;
  int postsCount;
  int followerCount;
  List<dynamic> moderators;
  bool isPublic;
  bool isMarketplace;
  bool isDeleted;

  Community(this.uid, this.rules,
      {this.name,
      this.description,
      this.iconPicUrl,
      this.bkdPicUrl,
      this.postsCount,
      this.followerCount,
      this.moderators,
      this.isMarketplace,
      this.isPublic,
      this.isDeleted});

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
        isDeleted = data['isDeleted'],
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
      'isDeleted': isDeleted
    };
  }
}
