import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  signIn() async {
    var googleUser = await openGoogleAccountChooser();
    await _authRequest(signInWithGoogle(googleUser), "Conectando con Google");
  }

  Future<GoogleSignInAccount> openGoogleAccountChooser() async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount googleUser =
        await _googleSignIn.signIn() as GoogleSignInAccount;
    return googleUser;
  }

  Future<UserCredential> signInWithGoogle(
      GoogleSignInAccount googleUser) async {
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    var result = await _firebaseAuth.signInWithCredential(credential);
    return result;
  }

  _authRequest(Future<UserCredential> future, String loadingMessage) async {
    try {
      await future.timeout(Duration(seconds: 10));
      // if ok firebase will return a user else will throw an exception
      Get.offAllNamed(AppRoutes.HOME);
      print(_firebaseAuth.currentUser);
    } catch (e) {
      Get.back();
      switch (e) {
        default:
          print(e);
      }
    }
  }

  signOut() async {
    Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  Stream<User?> onAuthChanged() {
    return _firebaseAuth.authStateChanges();
  }
}
