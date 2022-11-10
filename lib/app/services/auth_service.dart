import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ottaa_project_flutter/app/global_controllers/data_controller.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DataController dataController = Get.find<DataController>();

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
    final name = googleUser.displayName!;
    print('name from the google auth');
    print(name);
    final auth.OAuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredentials =
        await _firebaseAuth.signInWithCredential(credential);
    if (userCredentials.user != null) {
      print(userCredentials.user);
      // print(userCredentials.user!.photoURL);
      String url = userCredentials.user!.photoURL!;
      url.replaceFirst('s96-c', 's400-c');

      /// saving imageUrl in a sharedPref to be upload afterwards
      // await dataController.saveUserPhotoUrl(photoUrl: url);
      await saveImageUrlTobeUsedLater(imageUrl: url);
      // print(userCredentials.user!.email);
    }
    print('name from the firebae auth');
    print(userCredentials.user!.displayName);
    return userCredentials;
  }

  Future<auth.UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance
        .login(permissions: ["user_birthday", "user_gender", 'public_profile']);
    // Create a credential from the access token
    auth.OAuthCredential facebookAuthCredential =
        auth.FacebookAuthProvider.credential(result.accessToken!.token);
    print(result.accessToken!.token);
    // Once signed in, return the UserCredential
    var userCredentials = await auth.FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    if (userCredentials.user != null) {
      print(userCredentials.additionalUserInfo!.isNewUser);
      print(userCredentials.user);
      String url = userCredentials.user!.photoURL!;
      url = url + '?type=large';
      await saveImageUrlTobeUsedLater(imageUrl: url);
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
    final instance = await SharedPreferences.getInstance();
    await sharedPrefClient.setBool(
        Constants
            .LANGUAGE_CODES[instance.getString('Language_KEY') ?? 'Spanish']!,
        false);
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

  Future<void> saveImageUrlTobeUsedLater({required String imageUrl}) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString(
      'ImageUrl',
      imageUrl,
    );
  }
}
