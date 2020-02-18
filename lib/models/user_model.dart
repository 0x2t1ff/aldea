class User {
  final String name;
  final String uid;
  final String picUrl;
  final String bkdPicUrl;
  final int postsCount;
  final int vouchCount;
  final int communitiesCount;
  final int winCount;
  final String gender;
  final int age;
  final String phoneNumber;
  final String email;
  final String address;

  User(
      {this.name,
      this.uid,
      this.picUrl,
      this.bkdPicUrl,
      this.postsCount,
      this.vouchCount,
      this.communitiesCount,
      this.winCount,
      this.gender,
      this.age,
      this.phoneNumber,
      this.email,
      this.address});

  User.fromData(Map<String, dynamic> data)
      : name = data['name'],
        uid = data['uid'],
        picUrl = data['photoUrl'],
        bkdPicUrl = data['bkdPic'],
        postsCount = data['postsCount'],
        vouchCount = data['vouchCount'],
        communitiesCount = data['communitiesCount'],
        winCount = data['winCount'],
        gender = data['gender'],
        age = data['age'],
        phoneNumber = data['phoneNumber'],
        email = data['email'],
        address = data['address'];
}
