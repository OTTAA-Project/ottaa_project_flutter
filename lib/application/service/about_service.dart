import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
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
  Future<String> getAvailableAppVersion() => _serverRepository.getAvailableAppVersion();

  @override
  Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
      return webBrowserInfo.userAgent!;
    }

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model!;
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
      return user.email;
    }

    return result.left;
  }

  @override
  Future<UserType> getUserType() async {
    final result = await _auth.getCurrentUser();

    if (result.isLeft) {
      return UserType.free;
    }

    final user = result.right;

    return _serverRepository.getUserType(user.id);
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

    final String? url = await _serverRepository.getUserProfilePicture(id);
    //Return an default image
    return url ?? "671";
  }

  @override
  Future<void> uploadProfilePicture(String photo) async {
    final userResult = await _auth.getCurrentUser();
    if (userResult.isLeft) return;

    final UserModel user = userResult.right;

    await _serverRepository.uploadUserPicture(user.id, photo, user.photoUrl);
  }

  @override
  Future<Either<String, UserModel>> getUserInformation() async {
    final userResult = await _auth.getCurrentUser();
    if (userResult.isLeft) return Left(userResult.left);

    final UserModel user = userResult.right;

    final userData = await _serverRepository.getUserInformation(user.id);

    if (userData == null) return const Left("no_user_found");

    final UserModel newUser = UserModel.fromRemote(userData);

    return Right(newUser);
  }

  @override
  Future<void> uploadUserInformation() async {
    final userResult = await _auth.getCurrentUser();
    if (userResult.isLeft) return;

    final UserModel user = userResult.right;

    await _serverRepository.uploadUserInformation(user.id, user.toRemote());
  }

  @override
  Future<bool> isCurrentUserAvatarExist() async {
    final result = await _auth.getCurrentUser();
    if (result.isLeft) {
      return false;
    }

    return result.right.avatar != null || result.right.photoUrl == "0";
  }

  @override
  Future<bool> isFirstTime() async {
    final result = await _auth.getCurrentUser();

    if (result.isLeft) {
      return false;
    }

    return result.right.isFirstTime;
  }
}
