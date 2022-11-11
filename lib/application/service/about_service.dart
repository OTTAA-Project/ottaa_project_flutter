import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:either_dart/either.dart';
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

    /// Get the profile picture from the database at the new path
    final refNew = databaseRef.child('$id/Usuarios/Avatar/urlFoto/');
    final resNew = await refNew.get();
    print('here is new the user urlfoto');
    print(resNew.value);
    if (resNew.exists && resNew.value != null) {
      return resNew.value.toString();
    }

    /// Get the profile picture from the database at the old path
    final refOld = databaseRef.child('Avatar/$id/urlFoto/');
    final resOld = await refOld.get();
    print('here is the old user urlfoto');
    print(resOld.value);
    if (resOld.exists && resOld.value != null) {
      return resOld.value.toString();
    }

    //Return an default image
    return "671";
  }

  @override
  Future<void> uploadProfilePicture(String photo) async {
    final userResult = await _auth.getCurrentUser();
    if (userResult.isLeft) return;

    final UserModel user = userResult.right;

    final ref = databaseRef.child('${user.id}/Usuarios/Avatar/');

    await ref.update({
      //todo!: change the name over here and in the local db !!
      'name': 'TestName',
      'urlFoto': photo,
    });
  }

  @override
  Future<Either<String, UserModel>> getUserInformation() async {
    final userResult = await _auth.getCurrentUser();
    if (userResult.isLeft) return Left(userResult.left);

    final UserModel user = userResult.right;

    final userRef = databaseRef.child('${user.id}/Usuarios/');

    final userValue = await userRef.get();

    if (userValue.value == null) {
      return const Left('User not found');
    }

    final userPhoto = await getProfilePicture();

    final dynamic userData = userValue.value as dynamic;

    final UserModel newUser = user.copyWith(
      birthdate: userData['birth_date'],
      name: userData['Nombre'],
      gender: userData['pref_sexo'],
      photoUrl: userPhoto,
    );

    return Right(newUser);
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
      'Avatar': {
        //todo!: change the name over here and in the local db !!
        'name': user.photoUrl,
        'urlFoto': user.avatar,
      }
    });
  }

  @override
  Future<bool> isCurrentUserAvatarExist() async {
    final result = await _auth.getCurrentUser();
    if (result.isLeft) {
      return false;
    }

    final res = result.right;

    //Check for the new path
    final refNew = databaseRef.child('${res.id}/Usuarios/Avatar/urlFoto/');

    DataSnapshot photoDb = await refNew.get();

    if (photoDb.value == null || !photoDb.exists) {
      //Check for the old path
      final refOld = databaseRef.child('Avatar/${res.id}/urlFoto/');
      photoDb = await refOld.get();
    }

    return photoDb.value != null || photoDb.exists;
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
