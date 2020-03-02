class Community {
  final String name;
  final String description;
  final String iconPicUrl;
  final String bkdPicUrl;
  final String iconPicName;
  final String bkdPicName;
  final int postsCount;
  final int followerCount;
  final List<String> moderators;

  Community(
      {this.name,
      this.description,
      this.iconPicUrl,
      this.bkdPicUrl,
      this.iconPicName,
      this.bkdPicName,
      this.postsCount,
      this.followerCount,
      this.moderators});

  Community.fromData(Map<String, dynamic> data)
      : name = data['name'],
        description = data['description'],
        iconPicUrl = data['iconPicUrl'],
        iconPicName = data['iconPicName'],
        bkdPicUrl = data['bkdPicUrl'],
        bkdPicName = data['bkdPicName'],
        postsCount = data['postsCount'],
        followerCount = data['followerCount'],
        moderators = data['moderators'];
}
