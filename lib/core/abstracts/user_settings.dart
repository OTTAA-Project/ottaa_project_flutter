import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';

abstract class UserSettings {
  const UserSettings();

  LanguageSetting get language;
  set language(LanguageSetting language);

  UserData get data;
  set data(UserData data);

  Map<String, dynamic> toMap();
}
