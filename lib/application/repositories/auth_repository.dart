import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ottaa_project_flutter/application/notifiers/loading_notifier.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'dart:async';

import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';

final databaseRef = FirebaseDatabase.instance.ref();

class AuthRepositoryImpl with ChangeNotifier implements AuthRepository<User> {
  final LoadingNotifier loadingNotifier;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  AuthRepositoryImpl(this.loadingNotifier);

  @override
  FutureOr<Either<String, User>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  FutureOr<bool> isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  FutureOr<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  FutureOr<Either<String, User>> signIn(SignInType type) async {
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
        return const Left("error_no_implement_auth_method"); //TODO: Implement translate method.
    }

    final User? auth = FirebaseAuth.instance.currentUser;
    final ref = databaseRef.child('Usuarios/${auth!.uid}/');
    final res = await ref.get();
    if (res.exists) {
      // final instance = await SharedPreferences.getInstance();
      // instance.setBool('First_time', true);
      // instance.setBool('Avatar_photo', true);

    }

    return result;
  }

  FutureOr<Either<String, User>> _signInWithGoogle() async {
    try {
      loadingNotifier.showLoading();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return const Left("error_google_sign_in_cancelled");
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user == null) {
        return const Left("error_google_sign_in_cancelled");
      }

      final User user = userCredential.user!;

      return Right(user);
    } catch (e) {
      return Left(e.toString());
    } finally {
      loadingNotifier.hideLoading();
    }
  }

  FutureOr<Either<String, User>> _signInWithFacebook() async {
    try {
      loadingNotifier.showLoading();
      final LoginResult result = await _facebookAuth.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

        final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

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
    } finally {
      loadingNotifier.hideLoading();
    }
  }
}

final authProvider = ChangeNotifierProvider<AuthRepository<User>>((ref) {
  final loadingNotifier = ref.watch(loadingProvider.notifier);

  return AuthRepositoryImpl(loadingNotifier);
});
