Map<String, Object> generateInitialUserData(
        String id, String email, String name, String phoneNumber) =>
    {
      'uid': id,
      'name': name,
      'email': email,
      'picUrl':
          "https://firebasestorage.googleapis.com/v0/b/aldea-dev-40685.appspot.com/o/default-profile.png?alt=media&token=062950e5-c830-43e9-9869-7704e0accd66",
      'picName': null,
      'bkdPicUrl': null,
      'bkdPicName': null,
      'postsCount': 0,
      'communitiesCount': 0,
      'vouchCount': 0,
      'winCount': 0,
      'gender': '',
      'mod': [],
      'phoneNumber': phoneNumber,
      'address': '',
      'vouches': [],
      'communities': [],
      'chatRooms': [],
      'requests': [],
      'isGodAdmin': false,
      'notificationsEnabled': true,
      'language': null
    };
