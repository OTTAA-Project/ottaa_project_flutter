import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_settings.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/devices_token.dart';

abstract class UserModel extends HiveObject {
  UserModel();

  DeviceToken get currentToken;
  set currentToken(DeviceToken token);

  String get id;
  UserType get type;
  UserSettings get settings;
  set settings(UserSettings settings);
  String get email;

  UserModel fromJson(Map<String, dynamic> json);

  String toJson();

  Map<String, dynamic> toMap();
}
