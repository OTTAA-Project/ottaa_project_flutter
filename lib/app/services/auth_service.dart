import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<auth.User?> onAuthChanged() {
    return _firebaseAuth.authStateChanges();
  }

  Future<auth.UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<auth.UserCredential> signInWithGoogle() async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount googleUser =
        await _googleSignIn.signIn() as GoogleSignInAccount;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final auth.OAuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var userCredentials = await _firebaseAuth.signInWithCredential(credential);
    if (userCredentials.user != null) {}
    return userCredentials;
  }

  Future<auth.UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    auth.OAuthCredential facebookAuthCredential =
        auth.FacebookAuthProvider.credential(result.accessToken!.token);

    // Once signed in, return the UserCredential
    var userCredentials = await auth.FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    // if (userCredentials.user != null) {
    //   await _addUserToUsersCollectionIfNotExists(userCredentials.user.uid,
    //       userCredentials.user.email, userCredentials.user.displayName, "");
    // }
    return userCredentials;
  }

  // _addUserToUsersCollectionIfNotExists(
  //     String uid, String email, String name, String lastName) async {
  //   try {
  //     var user = await _userService.findById(uid);
  //     if (user == null) {
  //       user = User(
  //           documentID: email,
  //           email: email,
  //           name: name,
  //           lastName: lastName,
  //           type: "User",
  //           allowNegativeBalance: false);
  //       await _userService.createUser(user);
  //     } else {}
  //   } catch (e) {
  //     print(e.message);
  //     signOut();
  //   }
  // }

  auth.User getCurrentUser() {
    auth.User user = _firebaseAuth.currentUser as auth.User;
    return user;
  }

  Future<auth.UserCredential> signUp(
      {required String email,
      required String password,
      required String name}) async {
    auth.UserCredential result = await _firebaseAuth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .timeout(const Duration(seconds: 10));
    if (result.user != null) {
      print(
          "usar endpoint crear"); //  await .....  .timeout(const Duration(seconds: 10));
    }
    return result;
  }

  Future<String> getAccessToken() async {
    auth.User user = getCurrentUser();
    return await user.getIdToken();
  }

  Future<String> getRefreshToken() async {
    auth.User user = _firebaseAuth.currentUser as auth.User;
    return await user.getIdToken(true);
  }

  Future signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> sendEmailVerification() async {
    auth.User user = _firebaseAuth.currentUser as auth.User;
    await user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    auth.User user = _firebaseAuth.currentUser as auth.User;
    return user.emailVerified;
  }

  Future<void> changeEmail(String email) async {
    auth.User user = _firebaseAuth.currentUser as auth.User;
    await user.updateEmail(email);
  }

  Future<void> changePassword(String password) async {
    auth.User user = _firebaseAuth.currentUser as auth.User;
    user.updatePassword(password).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  Future<void> deleteUser() async {
    auth.User user = _firebaseAuth.currentUser as auth.User;
    user.delete().then((_) {
      print("Succesfull user deleted");
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  Future<void> sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }
}
