import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:ottaa_project_flutter/core/enums/sign_in_types.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
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

@Singleton(as: AuthRepository)
class AuthService extends AuthRepository {
  final FirebaseAuth _authProvider = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  final LocalDatabaseRepository _databaseRepository;
  final ServerRepository _serverRepository;

  AuthService(this._databaseRepository, this._serverRepository);

  @override
  Future<Either<String, UserModel>> getCurrentUser() async {
    UserModel? userDb = await _databaseRepository.getUser();
    if (userDb == null) {
      return const Left("No user logged");
    }

    return Right(userDb);
  }

  @override
  Future<String> runToGetDataFromOtherPlatform({
    required String email,
    required String id,
  }) async {
    final uri = Uri.parse(
      'https://us-central1-ottaaproject-flutter.cloudfunctions.net/getOldUserDataHttp?email=$email&uid=$id',
    );
    final res = await http.get(
      uri,
    );
    return res.body;
  }

  @override
  Future<bool> isLoggedIn() async {
    return _databaseRepository.user != null;
  }

  @override
  Future<void> logout() async {
    await _authProvider.signOut();
    await _googleSignIn.signOut();
    // await _facebookAuth.logOut(); //TODO!: Comment this line due a [MissingPluginException] error
    await _databaseRepository.deleteUser();
  }

  @override
  Future<Either<String, UserModel>> signIn(SignInType type, [String? email, String? password]) async {
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
      try {
        final User user = result.right;

        EitherMap userInfo = await _serverRepository.getUserInformation(user.uid);
        UserModel? userModel;
        if (userInfo.isLeft) {
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
                lastName: "",
                name: nameRetriever ?? "",
              ),
              language: LanguageSetting.empty(),
            ),
            email: emailRetriever ?? "",
          );
        } else {
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
        }

        userModel.currentToken = DeviceToken(deviceToken: await getDeviceId(), lastUsage: DateTime.now());

        await _serverRepository.updateDevicesId(
          userId: userModel.id,
          deviceToken: userModel.currentToken,
        );

        return Right(userModel);
      } on Exception catch (e) {
        print(e);
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
  bool get isLogged => _databaseRepository.user != null;

  @override
  Future<Either<String, bool>> signUp() async {
    final user = _authProvider.currentUser;

    if (user == null) {
      return const Left("error_user_not_logged");
    }

    final nameRetriever = user.displayName ?? user.providerData[0].displayName;
    final emailRetriever = user.email ?? user.providerData[0].email;

    final userModel = BaseUserModel(
      id: user.uid,
      settings: BaseSettingsModel(
        data: UserData(
          avatar: AssetsImage(asset: "671", network: user.photoURL),
          birthDate: DateTime.fromMillisecondsSinceEpoch(0),
          genderPref: "n/a",
          lastConnection: DateTime.now(),
          lastName: "",
          name: nameRetriever ?? "",
        ),
        language: LanguageSetting.empty(),
      ),
      email: emailRetriever ?? "",
    );
    await _serverRepository.uploadUserInformation(user.uid, userModel.toMap());

    return const Right(true);
  }

  @override
  Future<String> getDeviceId() async {
    return await FirebaseMessaging.instance.getToken() ?? "";
  }
}
