import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_settings.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';

part 'base_settings_model.g.dart';

@HiveType(typeId: HiveTypesIds.baseSettingsTypeId)
class BaseSettingsModel extends UserSettings {
  @override
  @HiveField(0)
  UserData data;

  @override
  @HiveField(1)
  LanguageSetting language;

  BaseSettingsModel({
    required this.data,
    required this.language,
  });

  BaseSettingsModel copyWith({
    UserData? data,
    LanguageSetting? language,
  }) {
    return BaseSettingsModel(
      data: data ?? this.data,
      language: language ?? this.language,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
      'language': language.toMap(),
    };
  }

  factory BaseSettingsModel.fromMap(Map<String, dynamic> map) {
    return BaseSettingsModel(
      data: UserData.fromMap(Map.from(map['data'] as dynamic)),
      language: map['language'] == null ? LanguageSetting.empty() : LanguageSetting.fromMap(Map.from(map['language'] as dynamic)),
    );
  }

  String toJson() => json.encode(toMap());

  factory BaseSettingsModel.fromJson(String source) => BaseSettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CaregiverSettings(data: $data, language: $language)';

  @override
  bool operator ==(covariant BaseSettingsModel other) {
    if (identical(this, other)) return true;

    return other.data == data && other.language == language;
  }

  @override
  int get hashCode => data.hashCode ^ language.hashCode;
}
