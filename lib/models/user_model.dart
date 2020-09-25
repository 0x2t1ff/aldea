class User {
  String name;
  String uid;
  String picUrl;
  String picName;
  String bkdPicUrl;
  String bkdPicName;
  int postsCount;
  int winCount;
  List<dynamic> communities;
  List<dynamic> requests;
  String gender;
  String phoneNumber;
  String email;
  String address;
  List<dynamic> vouches;
  List<String> onGoingQuickstrikes = [];
  List<dynamic> chatRooms;
  bool isGodAdmin;
  List<dynamic> mod;
  bool notificationsEnabled;

  User(
      {this.name,
      this.uid,
      this.picUrl,
      this.picName,
      this.bkdPicUrl,
      this.bkdPicName,
      this.postsCount,
      this.winCount,
      this.gender,
      this.phoneNumber,
      this.email,
      this.address,
      this.communities,
      this.vouches,
      this.onGoingQuickstrikes,
      this.requests,
      this.chatRooms,
      this.isGodAdmin,
      this.mod,
      this.notificationsEnabled});

  User.fromData(Map<String, dynamic> data)
      : name = data['name'],
        uid = data['uid'],
        picUrl = data['picUrl'],
        picName = data['picName'],
        bkdPicUrl = data['bkdPicUrl'],
        bkdPicName = data['bkdPicName'],
        postsCount = data['postsCount'],
        winCount = data['winCount'],
        gender = data['gender'],
        vouches = data['vouches'],
        phoneNumber = data['phoneNumber'],
        email = data['email'],
        address = data['address'],
        requests = data['requests'],
        chatRooms = data["chatRooms"],
        communities = data['communities'],
        isGodAdmin = data["isGodAdmin"],
        mod = data["mod"],
        notificationsEnabled = data["notificationsEnabled"];
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
      'winCount': winCount,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'address': address,
      'requests': requests,
      'communities': communities,
      'vouches': vouches,
      'chatRooms': chatRooms,
      'isGodAdmin': isGodAdmin,
      'moderator': mod,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  void updateFromData(Map<String, dynamic> data) {
    name = data['name'];
    uid = data['uid'];
    picUrl = data['picUrl'];
    picName = data['picName'];
    bkdPicUrl = data['bkdPicUrl'];
    bkdPicName = data['bkdPicName'];
    postsCount = data['postsCount'];
    winCount = data['winCount'];
    gender = data['gender'];
    vouches = data['vouches'];
    phoneNumber = data['phoneNumber'];
    email = data['email'];
    address = data['address'];
    requests = data['requests'];
    chatRooms = data["chatRooms"];
    communities = data['communities'];
    isGodAdmin = data["isGodAdmin"];
    mod = data["mod"];
    notificationsEnabled = data["notificationsEnabled"];
  }
}
