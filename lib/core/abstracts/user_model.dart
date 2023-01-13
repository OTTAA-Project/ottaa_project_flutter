import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_settings.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';

abstract class UserModel extends HiveObject {
  UserModel();

  String get id;
  UserType get type;
  UserSettings get settings;
  set settings(UserSettings settings);
  String get email;

  UserModel fromJson(Map<String, dynamic> json);

  String toJson();

  Map<String, dynamic> toMap();
}
