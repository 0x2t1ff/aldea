import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
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
          timeout: Duration(seconds:10),
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
}
