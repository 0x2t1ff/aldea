class User {
  final String name;
  final String uid;
  String picUrl;
  String picName;
  String bkdPicUrl;
  String bkdPicName;
  final int postsCount;
  final int vouchCount;
  final int winCount;
  List<dynamic> communities; 
  List<dynamic> requests;
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
      this.winCount,
      this.gender,
      this.phoneNumber,
      this.email,
      this.address,
      this.communities});

  User.fromData(Map<String, dynamic> data)
      : name = data['name'],
        uid = data['uid'],
        picUrl = data['picUrl'],
        picName = data['picName'],
        bkdPicUrl = data['bkdPicUrl'],
        bkdPicName = data['bkdPicName'],
        postsCount = data['postsCount'],
        vouchCount = data['vouchCount'],
        winCount = data['winCount'],
        gender = data['gender'],
        phoneNumber = data['phoneNumber'],
        email = data['email'],
        address = data['address'],
        requests = data['requests'],
        communities = data['communities'];

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
      'vouchCount': vouchCount,
      'winCount': winCount,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'address': address,
      'requests': requests,
      'communities': communities
    };
  }
}
