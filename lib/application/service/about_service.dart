import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/user_model.dart';
import 'dart:async';

import 'package:ottaa_project_flutter/core/repositories/about_repository.dart';
import 'package:ottaa_project_flutter/core/repositories/auth_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutService extends AboutRepository {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

  final AuthRepository _auth;

  AboutService(this._auth);

  @override
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Future<String> getAvailableAppVersion() async {
    final DatabaseReference ref = databaseRef.child('version/');
    final DataSnapshot res = await ref.get();
    return res.value.toString();
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

    final ref = databaseRef.child('Pago/${user.id}/Pago');
    final res = await ref.get();
    if (res.value == null) return UserType.free;

    return UserType.premium;
  }

  @override
  Future<void> sendSupportEmail() async {
    final data = await Future.wait([
      getEmail(),
      getAppVersion(),
      getAvailableAppVersion(),
      getDeviceName()
    ]);
    final userType = await getUserType();
    final Uri params = Uri(
        scheme: 'mailto',
        path: 'support@ottaaproject.com',
        queryParameters: {
          'subject': 'Support',
          'body':
              '''Account: ${data[0]},\nAccount Type: ${userType.name},\nCurrent OTTAA Installed: ${data[1]}\nCurrent OTTAA Version: ${data[3]}\nDevice Name: ${data[4]}''',
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

    final refNew = databaseRef.child('$id/Usuarios/Avatar/urlFoto/');
    final resNew = await refNew.get();
    if (resNew.exists && resNew.value != null) {
      return resNew.value as String;
    } else {
      final refOld = databaseRef.child('Avatar/$id/urlFoto/');
      final resOld = await refOld.get();
      print('here is the user urlfoto');
      print(resOld.value);
      return resOld.value as String;
    }
  }

  @override
  Future<void> uploadProfilePicture(String photo) async {
    final userResult = await _auth.getCurrentUser();
    if (userResult.isLeft) return;

    final UserModel user = userResult.right;

    final ref = databaseRef.child('${user.id}/Avatar/');
    await ref.set({
      //todo: change the name over here
      'name': 'TestName',
      'urlFoto': photo,
    });
  }

  @override
  Future<void> uploadUserInformation() async {
    final userResult = await _auth.getCurrentUser();
    if (userResult.isLeft) return;

    final UserModel user = userResult.right;

    final ref = databaseRef.child('${user.id}/Usuarios/');
    await ref.set(<String, Object>{
      'Nombre': user.name,
      'birth_date': user.birthdate ?? 0,
      'pref_sexo': user.gender ?? "N/A",
    });
  }

  @override
  Future<bool> isCurrentUserAvatarExist() async {
    final result = await _auth.getCurrentUser();
    if (result.isLeft) {
      return false;
    }

    final res = result.right;
    final refNew = databaseRef.child('${res.id}/Usuarios/Avatar/urlFoto/');

    DataSnapshot resNew = await refNew.get();

    if (resNew.value == null || !resNew.exists) {
      final refOld = databaseRef.child('Avatar/${res.id}/urlFoto/');
      resNew = await refOld.get();
    }

    return resNew.exists;
  }
}
