// coverage:ignore-file
import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:ottaa_project_flutter/core/enums/user_payment.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';
import 'package:ottaa_project_flutter/core/repositories/repositories.dart';

abstract class AboutRepository {
  Future<String> getEmail();

  Future<String> getAppVersion();

  Future<String> getDeviceName();

  Future<UserPayment> getUserType();

  Future<String> getAvailableAppVersion();

  Future<void> sendSupportEmail();

  Future<void> uploadUserInformation();

  Future<void> uploadProfilePicture(AssetsImage image);

  Future<String> getProfilePicture();

  Future<bool> isCurrentUserAvatarExist();

  Future<bool> isFirstTime();

  Future<Either<String, UserModel>> getUserInformation();

  Future<void> updateUserType({required String id, required UserType userType});

  Future<void> updateUserLastConnectionTime(
      {required String userId, required int time});
}
