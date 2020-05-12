class Community {
  final String uid;
  final String name;
  final String description;
  final String rules;
  final String iconPicUrl;
  final String bkdPicUrl;
  final String iconPicName;
  final String bkdPicName;
  final int postsCount;
  final int followerCount;
  final List<dynamic> moderators;

  Community(this.uid, this.rules, 
      {this.name,
      this.description,
      this.iconPicUrl,
      this.bkdPicUrl,
      this.iconPicName,
      this.bkdPicName,
      this.postsCount,
      this.followerCount,
      this.moderators});

  Community.fromData(Map<String, dynamic> data, String uid)
      : name = data['name'],
        uid = uid,
        description = data['description'],
        rules = data['rules'],
        iconPicUrl = data['iconPicUrl'],
        iconPicName = data['iconPicName'],
        bkdPicUrl = data['bkdPicUrl'],
        bkdPicName = data['bkdPicName'],
        postsCount = data['postsCount'],
        followerCount = data['followerCount'],
        moderators = data['moderators'];
}
