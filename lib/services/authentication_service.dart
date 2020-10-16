import 'package:aldea/constants/route_names.dart';
import 'package:aldea/locator.dart';
import 'package:aldea/services/dialog_service.dart';
import 'package:aldea/services/firestore_service.dart';
import 'package:aldea/utils/userDataCreator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import 'navigation_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigatorService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Future<String> getUserUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future logOut() async {
    return await _firebaseAuth.signOut();
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

  void signUpPhoneNumber(String phone, String email, String name,
      String password, Function setBusy) {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 20),
        verificationCompleted: (credential) async {
          var result = await _firebaseAuth.signInWithCredential(credential);
          if (result.user != null) {
            var userData =
                generateInitialUserData(result.user.uid, email, name, phone);
            registerCurrentUser(userData);
            await _firestoreService.createUser(User.fromData(userData));
            _navigatorService.navigateTo(HomeViewRoute, true);
          } else {
            _dialogService.showDialog(
                title: "Error",
                description:
                    "No se ha podido crear la cuenta. Por favor, intentalo de nuevo.");
          }
        },
        verificationFailed: (error) => print("error: " + error.message),
        codeSent: (verificationId, [token]) async {
          setBusy(false);
          var dialogResponse = await _dialogService.showPhoneCodeDialog(
              title: "Código de verificación");
          var credential = PhoneAuthProvider.getCredential(
              verificationId: verificationId,
              smsCode: dialogResponse.textField);
          var result = await _firebaseAuth.signInWithCredential(credential);
          if (result.user != null) {
            var userData =
                generateInitialUserData(result.user.uid, email, name, phone);
            registerCurrentUser(userData);
            await _firestoreService.createUser(User.fromData(userData));
            _navigatorService.navigateTo(HomeViewRoute, true);
          } else {
            _dialogService.showDialog(
                title: "Error",
                description:
                    "No se ha podido crear la cuenta. Por favor, intentalo de nuevo.");
          }
        },
        codeAutoRetrievalTimeout: null);
  }

  void loginPhoneNumber(String phone) {
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 20),
        verificationCompleted: (credential) async {
          var result = await _firebaseAuth.signInWithCredential(credential);
          if (result.user != null) {
            var userData = await _firestoreService.getUserData(result.user.uid);
            registerCurrentUser(userData);
            _navigatorService.navigateTo(HomeViewRoute, true);
          } else {
            _dialogService.showDialog(
                title: "Error",
                description:
                    "Ha ocurrido un error con la autentificacion. Por favor, intentalo de nuevo.");
          }
        },
        verificationFailed: (error) async => await _dialogService.showDialog(
            title: "Error", description: error.message),
        codeSent: (verificationId, [token]) async {
          var dialogResponse = await _dialogService.showPhoneCodeDialog(
              title: "Código de verificación");
          var credential = PhoneAuthProvider.getCredential(
              verificationId: verificationId,
              smsCode: dialogResponse.textField);
          var result = await _firebaseAuth.signInWithCredential(credential);
          if (result.user != null) {
            var userData = await _firestoreService.getUserData(result.user.uid);
            registerCurrentUser(userData);
            _navigatorService.navigateTo(HomeViewRoute, true);
          } else {
            _dialogService.showDialog(
                title: "Error",
                description:
                    "Ha ocurrido un error con la autentificacion. Por favor, intentalo de nuevo.");
          }
        },
        codeAutoRetrievalTimeout: (a) => print("a"));
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
