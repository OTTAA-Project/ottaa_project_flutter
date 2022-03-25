import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:ottaa_project_flutter/app/routes/app_routes.dart';
import 'package:ottaa_project_flutter/app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SignInType { EMAIL_PASSWORD, GOOGLE, FACEBOOK, APPLE }

var firebaseUser = FirebaseAuth.instance.currentUser;
final databaseRef = FirebaseDatabase.instance.reference();

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  User? get firebaseUser => auth.FirebaseAuth.instance.currentUser;

  late AuthService _authService;

  @override
  void onInit() async {
    // init services used by the controller
    _authService = AuthService();

    super.onInit();
  }

  bool _validateEmailAndPassword(String email, String password) {
    if (email == null || email.isEmpty || !GetUtils.isEmail(email)) {
      print("no email válido");
      // AppDialogs.showInvalidEmailDialog();
      return false;
    }
    if (password == null || password.isEmpty) {
      print("no pass null");
      // AppDialogs.showEmptyPasswordDialog();
      return false;
    }
    return true;
  }

  Future<void> handleSignIn(SignInType type,
      {String? email, String? password, String? name}) async {
    if (type == SignInType.EMAIL_PASSWORD) {
      if (!_validateEmailAndPassword(email!, password!)) return;
      await _authRequest(
          _authService.signInWithEmailAndPassword(email, password),
          "Ingresando");
    }
    if (type == SignInType.GOOGLE) {
      await _authRequest(
          _authService.signInWithGoogle(), "Conectando con Google");
    }
    if (type == SignInType.FACEBOOK) {
      await _authRequest(
          _authService.signInWithFacebook(), "Conectando con Facebook");
    }
  }

  // handleSignUp(
  //     String email, String password, String name, String lastName) async {
  //   if (!_validateEmailAndPassword(email, password)) return;
  //   await _authRequest(
  //       _authService.signUp(email, password, name: name, lastName: lastName),
  //       "Registrando");
  // }

  handleSignOut() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  _authRequest(
      Future<auth.UserCredential> future, String loadingMessage) async {
    // Get.to(VulleticLoading(textToShow: loadingMessage));
    try {
      await future;
      // if ok firebase will return a user else will throw an exception
      final User? auth = FirebaseAuth.instance.currentUser;
      final ref = databaseRef.child('Usuarios/${auth!.uid}/');
      final res = await ref.get();
      if (res.exists) {
        final instance = await SharedPreferences.getInstance();
        instance.setBool('First_time', true);
        instance.setBool('Avatar_photo', true);
        Get.offAllNamed(AppRoutes.HOME);
      } else {
        Get.offAllNamed(AppRoutes.ONBOARDING);
      }
    } catch (e) {
      Get.back();
      // switch (e.code) {
      //   // case 'sign_in_failed':
      //   //   this error comes due to fingerprint SHA1 and SHA256
      //   //   AppDialogs.showInformationDialog("Error en el Login",
      //   //       "La aplicación no se pudo loguear (sign-in-failed)");
      //   //   break;
      //   // case 'account-exists-with-different-credential':
      //   //   AppDialogs.showInformationDialog("Ya exite la cuenta",
      //   //       "El mail de la cuenta está asociado a otro método de login");
      //   //   break;
      //   // case "too-many-requests":
      //   //   AppDialogs.showInformationDialog("Límite de intentos alcanzado",
      //   //       "Espere unos minutos y vuelva a intentar acceder nuevamente");
      //   //   break;
      //   // case "email-already-exists":
      //   //   AppDialogs.showEmailAlreadyExistsDialog();
      //   //   break;
      //   // case 'weak-password':
      //   //   AppDialogs.showWeakPasswordDialog();
      //   //   break;
      //   // case 'invalid-email':
      //   //   AppDialogs.showInvalidEmailDialog();
      //   //   break;
      //   // case 'invalid-password':
      //   //   AppDialogs.showInvalidPasswordDialog();
      //   //   break;
      //   // case 'user-not-found':
      //   //   AppDialogs.showUserNotFoundDialog();
      //   // break;
      //   default:
      //     // AppDialogs.showUnknownErrorDialog();
      //     print(e);
      // }
    }
  }
}
