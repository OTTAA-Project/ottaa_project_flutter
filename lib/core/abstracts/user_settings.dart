import 'package:ottaa_project_flutter/core/models/user_data_model.dart';

abstract class UserSettings {
  const UserSettings();

  String get language;
  UserData get data;
}
