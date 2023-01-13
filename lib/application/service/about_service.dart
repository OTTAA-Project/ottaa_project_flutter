import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:ottaa_project_flutter/core/enums/user_payment.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/models/base_user_model.dart';
import 'package:ottaa_project_flutter/core/models/caregiver_user_model.dart';
import 'package:ottaa_project_flutter/core/models/patient_user_model.dart';
import 'dart:async';

import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/server_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutService extends AboutRepository {
  final ServerRepository _serverRepository;

  final AuthRepository _auth;

  AboutService(this._auth, this._serverRepository);

  @override
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Future<String> getAvailableAppVersion() async {
    final platform = Platform.isAndroid ? "android" : "ios";

    final Either<String, String> result = await _serverRepository.getAvailableAppVersion(platform);

    return result.fold((l) => l, (r) => r);
  }

  @override
  Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      return webBrowserInfo.userAgent!;
    }

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.utsname.machine!;
    }

    return 'Unknown';
  }

  @override
  Future<String> getEmail() async {
    final result = await _auth.getCurrentUser();

    if (result.isRight) {
      final user = result.right;
      return "";
      // return user.settings.data.;
    }

    return result.left;
  }

  @override
  Future<UserPayment> getUserType() async {
    final result = await _auth.getCurrentUser();

    if (result.isLeft || result.right.type == UserType.caregiver) {
      return UserPayment.free;
    }

    return (result.right as PatientUserModel).patientSettings.payment.payment ? UserPayment.premium : UserPayment.free;
  }

  @override
  Future<void> sendSupportEmail() async {
    final data = await Future.wait([getEmail(), getAppVersion(), getAvailableAppVersion(), getDeviceName()]);
    final userType = await getUserType();
    final Uri params = Uri(scheme: 'mailto', path: 'support@ottaaproject.com', queryParameters: {
      'subject': 'Support',
      'body': '''Account: ${data[0]},\nAccount Type: ${userType.name},\nCurrent OTTAA Installed: ${data[1]}\nCurrent OTTAA Version: ${data[3]}\nDevice Name: ${data[4]}''',
    });
    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      print('Could not launch ${params.toString()}');
    }
  }

  @override
  Future<String> getProfilePicture() async {
    final userResult = await _auth.getCurrentUser();
    if (userResult.isLeft) return userResult.left;

    final String id = userResult.right.id;

    final EitherString url = await _serverRepository.getUserProfilePicture(id);

    return url.fold((left) => "671", (right) => right);
  }

  @override
  Future<void> uploadProfilePicture(AssetsImage image) async {
    final userResult = await _auth.getCurrentUser();
    if (userResult.isLeft) return;

    final UserModel user = userResult.right;

    await _serverRepository.uploadUserPicture(user.id, user.settings.data.avatar.copyWith(asset: image.asset, network: image.network));
  }

  @override
  Future<Either<String, UserModel>> getUserInformation() async {
    final userResult = await _auth.getCurrentUser();

    print(userResult);

    if (userResult.isLeft) return Left(userResult.left);

    final UserModel user = userResult.right;

    final userData = await _serverRepository.getUserInformation(user.id);

    if (userData.isLeft) return const Left("no_user_found");

    UserModel model;

    switch (userData.right["type"]) {
      case "caregiver":
        model = CaregiverUserModel.fromMap({
          "email": user.email,
          ...userData.right,
        });
        break;
      case "user":
        model = PatientUserModel.fromMap({
          "email": user.email,
          ...userData.right,
        });
        break;
      case "none":
      default:
        model = BaseUserModel.fromMap({
          "email": user.email,
          ...userData.right,
        });
    }
    return Right(model);
  }

  @override
  Future<void> uploadUserInformation() async {
    final userResult = await _auth.getCurrentUser();
    if (userResult.isLeft) return;

    final UserModel user = userResult.right;

    await _serverRepository.uploadUserInformation(user.id, user.toMap());
  }

  @override
  Future<bool> isCurrentUserAvatarExist() async {
    final result = await _auth.getCurrentUser();
    if (result.isLeft) {
      return false;
    }

    return result.right.settings.data.avatar.network != null;
  }

  @override
  Future<bool> isFirstTime() async {
    final result = await _auth.getCurrentUser();

    if (result.isLeft) {
      return false;
    }
    //TODO: Check for first time!
    return result.right.settings.data.birthDate == DateTime(0);
  }

  @override
  Future<void> updateUserType({required String id, required UserType userType}) async {
    await _serverRepository.updateUserType(id: id, userType: userType);
  }
}
