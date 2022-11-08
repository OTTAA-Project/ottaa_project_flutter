import 'dart:async';

import 'package:ottaa_project_flutter/core/enums/user_types.dart';

abstract class AboutRepository {
  Future<String> getEmail();
  Future<String> getAppVersion();
  Future<String> getDeviceName();
  Future<UserType> getUserType();
  Future<String> getAvailableAppVersion();
  Future<void> sendSupportEmail();
  Future<void> uploadUserInformation();

  Future<void> uploadProfilePicture(String photo);

  Future<String> getProfilePicture();

  Future<bool> isCurrentUserAvatarExist();
}
