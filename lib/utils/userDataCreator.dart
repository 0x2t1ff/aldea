Map<String, Object> generateInitialUserData(
        String id, String email, String name, String phoneNumber) =>
    {
      'uid': id,
      'name': name,
      'email': email,
      'picUrl': null,
      'picName': null,
      'bkdPicUrl': null,
      'bkdPicName': null,
      'postsCount': 0,
      'communitiesCount': 0,
      'vouchCount': 0,
      'winCount': 0,
      'gender': '',
      'phoneNumber': phoneNumber,
      'address': '',
      'vouches': [],
      'communities': [],
      'chatRooms': [],
      'requests': [],
      'isGodAdmin': false,
    };
