import 'package:aldea/locator.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future<String> getUserUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
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
        'bkdPicName' : null,
        'postsCount': 0,
        'communitiesCount': 0,
        'vouchCount': 0,
        'winCount': 0,
        'gender': null,
        'phoneNumber': null,
        'address': null
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
          phoneNumber: null,
          timeout: Duration(seconds: 10),
          verificationCompleted: verifactionCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: null);
    } catch (e) {}
  }

  Future verificationCompleted(AuthCredential credential) async {
    try {
      var user = await _firebaseAuth.currentUser();
      return (await user.linkWithCredential(credential)) != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    return user != null;
  }

  Future<FirebaseUser> getUserID() async {
    var userId = _firebaseAuth.currentUser();
    return userId;
  }
}
