import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ottaa_project_flutter/application/database/sql_database.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'dart:async';

import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';

class AuthService extends AuthRepository {
  final FirebaseAuth _authProvider = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  final databaseRef = FirebaseDatabase.instance.ref();

  AuthService();

  @override
  Future<Either<String, UserModel>> getCurrentUser() async {
    User? user = _authProvider.currentUser;

    if (user != null) {
      UserModel? model = SqlDatabase.user;

      model ??= UserModel(
        id: user.uid,
        name: user.displayName ?? "No Available",
        email: user.email!,
        photoUrl: user.photoURL ?? "",
      );

      await SqlDatabase.db.setUser(model);

      return Right(model);
    } else {
      return const Left("user_not_logged"); //TODO: Translate
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return SqlDatabase.user != null;
  }

  @override
  Future<void> logout() async {
    await _authProvider.signOut();
    await _googleSignIn.signOut();
    // await _facebookAuth.logOut(); //TODO!: Comment this line due a [MissingPluginException] error
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
        return const Left("error_no_implement_auth_method"); //TODO: Implement translate method.
    }

    if (result.isRight) {
      final User user = result.right;

      final ref = databaseRef.child('${user.uid}/Usuarios/');
      final res = await ref.get();

      ///sometimes the email does not come with the user.email, it is given in the providedData,

      if (res.value == null || !res.exists) {
        await signUp();
      }

      late String email;

      if (user.email == null) {
        email = user.providerData[0].email!;
      } else {
        email = user.email!;
      }

      final userNameRef = databaseRef.child('${user.uid}/Usuarios/Nombre');
      final userName = await userNameRef.get();

      final UserModel userModel = UserModel(
        id: user.uid,
        name: user.displayName ?? userName.value?.toString() ?? "No Available",
        email: email,
        isFirstTime: res.exists,
        photoUrl: user.photoURL ?? "",
      );
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

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _authProvider.signInWithCredential(credential);

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

        final AuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

        final UserCredential userCredential = await _authProvider.signInWithCredential(credential);

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

  @override
  bool get isLogged => SqlDatabase.user != null;

  @override
  Future<Either<String, bool>> signUp() async {
    final user = _authProvider.currentUser;

    if (user == null) {
      return const Left("error_user_not_logged");
    }

    final ref = databaseRef.child('${user.uid}/Usuarios/');

    await ref.set(<String, Object>{
      'Nombre': user.displayName!,
      'birth_date': 0,
      'pref_sexo': "N/A",
      'Avatar': {
        //todo!: change the name over here and in the local db !!
        'name': user.photoURL,
        'urlFoto': 617,
      }
    });

    return const Right(true);
  }
}
