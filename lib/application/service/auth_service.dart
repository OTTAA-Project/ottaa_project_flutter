import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/application/common/i18n.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'dart:async';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/caregiver_user_model.dart';
import 'package:ottaa_project_flutter/core/models/devices_token.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/local_database_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@Singleton(as: AuthRepository)
class AuthService extends AuthRepository {
  late final FirebaseAuth _authProvider;
  late final GoogleSignIn _googleSignIn;
  late final FirebaseMessaging _firebaseMessaging;
  String lastName = '';
  String name = '';
  final LocalDatabaseRepository _databaseRepository;
  final ServerRepository _serverRepository;
  late AuthorizationCredentialAppleID result;
  final I18N _i18n;

  AuthService(
    this._databaseRepository,
    this._serverRepository,
    this._i18n, {
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FirebaseMessaging? firebaseMessaging,
  }) {
    _authProvider = firebaseAuth ?? FirebaseAuth.instance;
    _googleSignIn = googleSignIn ??
        GoogleSignIn(scopes: [
          'email',
        ]);
    _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;
  }

  @factoryMethod
  factory AuthService.from(LocalDatabaseRepository databaseRepository, ServerRepository serverRepository, I18N i18n) {
    return AuthService(databaseRepository, serverRepository, i18n);
  }

  @override
  Future<Either<String, UserModel>> getCurrentUser() async {
    UserModel? userDb = await _databaseRepository.getUser();
    if (userDb == null) {
      return const Left("No user logged");
    }

    return Right(userDb);
  }

  @override
  Future<bool> isLoggedIn() async {
    final currentAuthUser = _authProvider.currentUser;

    UserModel? userModel = _databaseRepository.user;

    if (currentAuthUser == null && userModel == null) {
      return false;
    }

    if (currentAuthUser != null && userModel == null) {
      userModel = await buildUserModel(currentAuthUser);
      if (userModel != null) {
        await _databaseRepository.setUser(userModel);

        return true;
      }
    }

    return _databaseRepository.user != null;
  }

  @override
  Future<void> logout() async {
    if (_authProvider.currentUser != null) {
      await _authProvider.signOut();
    }
    // await _facebookAuth.logOut(); //TODO!: Comment this line due a [MissingPluginException] error
    await _databaseRepository.deleteUser();
  }

  Future<UserModel?> buildUserModel(user) async {
    EitherMap userInfo = await _serverRepository.getUserInformation(user.uid);
    UserModel? userModel;
    if (userInfo.isLeft) {
      return null;
    }
    switch (userInfo.right["type"]) {
      case "caregiver":
        userModel = CaregiverUserModel.fromMap({
          ...userInfo.right,
          "email": user.email ?? user.providerData[0].email,
        });
        break;
      case "user":
        userModel = PatientUserModel.fromMap({
          ...userInfo.right,
          "email": user.email ?? user.providerData[0].email,
        });
        break;
      case "none":
      default:
        userModel = BaseUserModel.fromMap({
          ...userInfo.right,
          "email": user.email ?? user.providerData[0].email,
        });
        break;
    }

    userModel.currentToken = DeviceToken(deviceToken: await getDeviceId(), lastUsage: DateTime.now());
    if (userModel.currentToken != null) {
      await _serverRepository.updateDevicesId(
        userId: userModel.id,
        deviceToken: userModel.currentToken!,
      );
    }

    return userModel;
  }

  @override
  Future<Either<String, UserModel>> signIn(SignInType type, [String? email, String? password]) async {
    Either<String, User> result;
    final appleData = await _databaseRepository.getAppleUserData();

    switch (type) {
      case SignInType.google:
        result = await _signInWithGoogle();
        break;
      case SignInType.apple:
        result = await _signInWithApple();
        break;
      default:
        return const Left("error_no_implement_auth_method"); //TODO: Implement translate method.
    }

    if (result.isRight) {
      try {
        final User user = result.right;

        UserModel? userModel = await buildUserModel(user);

        if (userModel == null) {
          await signUp();

          final nameRetriever = user.displayName ?? user.providerData[0].displayName;
          final emailRetriever = user.email ?? user.providerData[0].email;

          userModel = BaseUserModel(
            id: user.uid,
            settings: BaseSettingsModel(
              data: UserData(
                avatar: AssetsImage(asset: "671", network: user.photoURL),
                birthDate: DateTime.fromMillisecondsSinceEpoch(0),
                genderPref: "n/a",
                lastConnection: DateTime.now(),
                lastName: Platform.isIOS ? appleData['lastname']! : lastName,
                name: Platform.isIOS ? appleData['name']! : nameRetriever!,
              ),
              language: LanguageSetting.empty(
                language: _i18n.currentLocale.toString(),
              ),
            ),
            email: emailRetriever ?? "",
          );
        }

        return Right(userModel);
      } on Exception catch (e) {
        await _authProvider.signOut();
        return Left("Error interno: ${e.toString()}");
      }
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
      // lastName = userCredential.additionalUserInfo?.profile?['family_name'] ?? "";
      // name = userCredential.additionalUserInfo?.profile?['given_name'] ?? "";

      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /* Future<Either<String, User>> _signInWithFacebook() async {
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
  }*/
  Future<Either<String, User>> _signInWithApple() async {
    try {
      result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      if (result.givenName != null) {
        _databaseRepository.setAppleUserDara(data: {
          'name': result.givenName!,
          'lastname': result.familyName!,
          'email': result.email!,
        });
      }
      final credential = OAuthProvider('apple.com').credential(
        idToken: result.identityToken,
        accessToken: result.authorizationCode,
      );

      final UserCredential userCredential = await _authProvider.signInWithCredential(credential);

      if (userCredential.user == null) {
        return const Left("error_apple_sign_in_cancelled");
      }

      final User user = userCredential.user!;

      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  bool get isLogged => _databaseRepository.user != null;

  @override
  Future<Either<String, bool>> signUp() async {
    final user = _authProvider.currentUser;
    final appleData = await _databaseRepository.getAppleUserData();

    if (user == null) {
      return const Left("error_user_not_logged");
    }

    final nameRetriever = user.displayName ?? user.providerData[0].displayName;
    final String emailRetriever = user.email ?? user.providerData[0].email!;

    final userModel = BaseUserModel(
      id: user.uid,
      settings: BaseSettingsModel(
        data: UserData(
          avatar: AssetsImage(asset: "671", network: user.photoURL),
          birthDate: DateTime.fromMillisecondsSinceEpoch(0),
          genderPref: "n/a",
          lastConnection: DateTime.now(),
          lastName: Platform.isIOS ? appleData['lastname']! : '',
          name: Platform.isIOS ? appleData['name']! : nameRetriever!,
        ),
        language: LanguageSetting.empty(
          language: _i18n.currentLocale.toString(),
        ),
      ),
      email: emailRetriever,
    );
    await _serverRepository.uploadUserInformation(user.uid, userModel.toMap());

    return const Right(true);
  }

  @override
  Future<String> getDeviceId() async {
    return await _firebaseMessaging.getToken(
          vapidKey: kIsWeb ? "BM1DJoICvUa0DM7SYOJE4aDc_Odtlbq5QKXRgB5XoeHEY7EIIP-39WnCqr-QNmNSDoRJEbNyq6LV7bUE6FoGWVE" : null,
        ) ??
        "";
  }
}
