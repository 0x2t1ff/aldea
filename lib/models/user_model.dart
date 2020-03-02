class User {
  final String name;
  final String uid;
  String picUrl;
  String picName;
  String bkdPicUrl;
  String bkdPicName;
  final int postsCount;
  final int vouchCount;
  final int communitiesCount;
  final int winCount;
  String gender;
  String phoneNumber;
  String email;
  String address;

  User(
      {this.name,
      this.uid,
      this.picUrl,
      this.picName,
      this.bkdPicUrl,
      this.bkdPicName,
      this.postsCount,
      this.vouchCount,
      this.communitiesCount,
      this.winCount,
      this.gender,
      this.phoneNumber,
      this.email,
      this.address});

  User.fromData(Map<String, dynamic> data)
      : name = data['name'],
        uid = data['uid'],
        picUrl = data['picUrl'],
        picName = data['picName'],
        bkdPicUrl = data['bkdPicUrl'],
        bkdPicName = data['bkdPicName'],
        postsCount = data['postsCount'],
        vouchCount = data['vouchCount'],
        communitiesCount = data['communitiesCount'],
        winCount = data['winCount'],
        gender = data['gender'],
        phoneNumber = data['phoneNumber'],
        email = data['email'],
        address = data['address'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'picUrl': picUrl,
      'picName': picName,
      'bkdPicUrl': bkdPicUrl,
      'bkdPicName': bkdPicName,
      'postsCount': postsCount,
      'communitiesCount': communitiesCount,
      'vouchCount': vouchCount,
      'winCount': winCount,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'address': address
    };
  }
}
