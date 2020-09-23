import 'package:aldea/locator.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthenticationService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  String getUserUID() {
    return _firebaseAuth.currentUser.uid;
  }

  auth.User getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future logOut() {
    _firebaseAuth.signOut();
  }

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signupWithEmail({
    @required String email,
    @required String password,
    @required String name,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var userData = {
        'uid': authResult.user.uid,
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
        'phoneNumber': '',
        'address': '',
        'vouches': [],
        'communities': [],
        'chatRooms': [],
        'requests': [],
        'isGodAdmin': false,
      };
      registerCurrentUser(userData);

      await _firestoreService.createUser(User.fromData(userData));

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future verifyPhone(
      {@required String phoneNumber,
      @required Function codeSent,
      @required Function verifactionCompleted,
      @required Function verificationFailed}) async {
    try {
      _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: Duration(seconds: 10),
          verificationCompleted: verifactionCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: null);
    } catch (e) {
      print(e.error);
    }
  }

  Future phoneAuth(String phone, Function codeSent) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (credential) => print("verificationCompleted"),
        verificationFailed: (auth.FirebaseAuthException exception) =>
            print(exception.message),
        codeSent: (validationId, [token]) => codeSent(validationId),
        codeAutoRetrievalTimeout: (value) => print("codeAutroRetrivalTimeout"));
  }

  Future linkCredentials(auth.AuthCredential credential) async {
    var response = await _firebaseAuth.signInWithCredential(credential);
    print("it gets here");
    return response.user;
  }
}
