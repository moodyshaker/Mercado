import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static final Auth instance = Auth._instance();
  static const String success = 'SUCCESS';
  FirebaseAuth _firebaseAuth;
  FirebaseApp _app;

  Auth._instance();

  Future<FirebaseApp> initAuth() async {
    if (_app == null) {
      _app = await _initFirebaseApp();
    }
    return _app;
  }

  Future<FirebaseApp> _initFirebaseApp() async {
    _app = await Firebase.initializeApp();
    _firebaseAuth = FirebaseAuth.instance;
    return _app;
  }

  User get user => _firebaseAuth.currentUser;

  Future<String> googleAuth() async {
    GoogleSignInAccount user = await GoogleSignIn().signIn();
    GoogleSignInAuthentication authentication = await user.authentication;
    GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken);
    String res = await userCredential(credential);
    return res;
  }

  Future<String> facebookAuth() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      FacebookAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken.token);
      String res = await userCredential(credential);
      return res;
    } on FacebookAuthErrorCode catch (e) {
      return e.toString();
    }
  }

  Future<String> loginAccount(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return success;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> userCredential(AuthCredential credential) async {
    try {
      await _firebaseAuth.signInWithCredential(credential);
      return Auth.success;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<List<String>> checkAccount(String email) async {
    List<String> emails = await _firebaseAuth.fetchSignInMethodsForEmail(email);
    return emails;
  }

  Future<String> verifyEmail() async {
    try {
      await _firebaseAuth.currentUser.sendEmailVerification();
      return success;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> updateProfile({String username, String imageUrl}) async {
    try {
      await _firebaseAuth.currentUser
          .updateProfile(displayName: username, photoURL: imageUrl);
      return success;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> forgetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return success;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return success;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createNewAccount({
    @required String email,
    @required String password,
    String username,
    String imageUrl,
  }) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user
          .updateProfile(displayName: username, photoURL: imageUrl);
      return success;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
