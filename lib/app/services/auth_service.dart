import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

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
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final auth.OAuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredentials =
        await _firebaseAuth.signInWithCredential(credential);
    if (userCredentials.user != null) {
      print(userCredentials.user);
      print(userCredentials.user!.email);
    }
    return userCredentials;
  }

  Future<auth.UserCredential> signInWithFacebook() async {
    await FacebookAuth.i.logOut();
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    auth.OAuthCredential facebookAuthCredential =
        auth.FacebookAuthProvider.credential(result.accessToken!.token);

    // Once signed in, return the UserCredential
    var userCredentials = await auth.FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    if (userCredentials.user != null) {
      print(userCredentials.user);
    }
    return userCredentials;
  }

  auth.User getCurrentUser() {
    auth.User? user = _firebaseAuth.currentUser;
    return user!;
  }

  // Future<auth.UserCredential> signUp(String email, String password,
  //     {String name, String lastName}) async {
  //   auth.UserCredential result = await _firebaseAuth
  //       .createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       )
  //       .timeout(const Duration(seconds: 10));
  //   name = name ?? result.user.displayName;
  //   lastName = lastName ?? "";
  //   if (result.user != null) {
  //     await _addUserToUsersCollectionIfNotExists(
  //             result.user.uid, result.user.email, name + ' ' + lastName, "")
  //         .timeout(const Duration(seconds: 10));
  //     await result.user.updateProfile(displayName: name + ' ' + lastName);
  //   }
  //   return result;
  // }

  Future<String> getAccessToken() async {
    auth.User user = getCurrentUser();
    return await user.getIdToken();
  }

  Future<String> getRefreshToken() async {
    auth.User? user = _firebaseAuth.currentUser;
    return await user!.getIdToken(true);
  }

  Future<void> signOut() async {
    final sharedPrefClient = await SharedPreferences.getInstance();
    await sharedPrefClient.setBool('First_time', false);
    await sharedPrefClient.setBool('Pictos_file', false);
    Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  Future<void> sendEmailVerification() async {
    auth.User? user = _firebaseAuth.currentUser;
    await user!.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    auth.User? user = _firebaseAuth.currentUser;
    return user!.emailVerified;
  }

  Future<void> changeEmail(String email) async {
    auth.User? user = _firebaseAuth.currentUser;
    await user!.updateEmail(email);
  }

  Future<void> changePassword(String password) async {
    auth.User? user = _firebaseAuth.currentUser;
    user!.updatePassword(password).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  Future<void> deleteUser() async {
    auth.User? user = _firebaseAuth.currentUser;
    user!.delete().then((_) {
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
