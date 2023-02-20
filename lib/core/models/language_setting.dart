import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

part 'language_setting.g.dart';

@HiveType(typeId: HiveTypesIds.languageSettingTypeId)
class LanguageSetting {
  @HiveField(0)
  String language;

  @HiveField(1, defaultValue: false)
  bool labs;

  LanguageSetting({
    required this.language,
    required this.labs,
  });

  factory  LanguageSetting.empty() {
    return LanguageSetting(
      language: 'es_AR',
      labs: false,
    );
  }

  LanguageSetting copyWith({
    String? language,
    bool? labs,
  }) {
    return LanguageSetting(
      language: language ?? this.language,
      labs: labs ?? this.labs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language,
      'labs': labs,
    };
  }

  factory LanguageSetting.fromMap(Map<String, dynamic> map) {
    return LanguageSetting(
      language: map['language'] as String,
      labs: map['labs'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageSetting.fromJson(String source) => LanguageSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LanguageSetting(language: $language, labs: $labs)';

  @override
  bool operator ==(covariant LanguageSetting other) {
    if (identical(this, other)) return true;

    return other.language == language && other.labs == labs;
  }

  @override
  int get hashCode => language.hashCode ^ labs.hashCode;
}
