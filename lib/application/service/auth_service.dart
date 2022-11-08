import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'dart:async';

import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';

class AuthServiceImpl extends AuthRepository {
  final FirebaseAuth _authProvider = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  final databaseRef = FirebaseDatabase.instance.ref();

  AuthServiceImpl();

  @override
  Future<Either<String, UserModel>> getCurrentUser() async {
    User? user = _authProvider.currentUser;

    if (user != null) {
      final UserModel userModel = UserModel(
          id: user.uid,
          name: user.displayName ?? "No Available",
          email: user.email!,
          photoUrl: user.photoURL);
      return Right(userModel);
    } else {
      return const Left("user_not_logged"); //TODO: Translate
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return _authProvider.currentUser != null;
  }

  @override
  Future<void> logout() async {
    await _authProvider.signOut();
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
  }

  @override
  Future<Either<String, UserModel>> signIn(SignInType type) async {
    Either<String, User> result;

    switch (type) {
      case SignInType.google:
        result = await _signInWithGoogle();
        break;
      case SignInType.facebook:
        result = await _signInWithFacebook();
        break;
      case SignInType.apple:
      case SignInType.email:
      default:
        return const Left(
            "error_no_implement_auth_method"); //TODO: Implement translate method.
    }

    if (result.isRight) {
      final User user = result.right;

      final ref = databaseRef.child('Usuarios/${user.uid}/');
      final res = await ref.get();
      if (res.exists) {
        // final instance = await SharedPreferences.getInstance();
        // instance.setBool('First_time', true);
        // instance.setBool('Avatar_photo', true);

      }

      ///sometimes the email does not come with the user.email, it is given in the providedData,

      late String email;

      if (user.email == null) {
        email = user.providerData[0].email!;
      } else {
        email = user.email!;
      }
      final UserModel userModel = UserModel(
          id: user.uid,
          name: user.displayName ?? "No Available",
          email: email,
          photoUrl: user.photoURL);
      return Right(userModel);
    }

    return Left(result.left);
  }

  Future<Either<String, User>> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return const Left("error_google_sign_in_cancelled");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _authProvider.signInWithCredential(credential);

      if (userCredential.user == null) {
        return const Left("error_google_sign_in_cancelled");
      }

      final User user = userCredential.user!;

      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, User>> _signInWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final UserCredential userCredential =
            await _authProvider.signInWithCredential(credential);

        if (userCredential.user == null) {
          return const Left("error_facebook_sign_in_cancelled");
        }

        final User user = userCredential.user!;
        return Right(user);
      } else {
        return const Left("error_facebook_sign_in_cancelled");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
