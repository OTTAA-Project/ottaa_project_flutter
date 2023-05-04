// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_settings.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/accessibility_setting.dart';
import 'package:ottaa_project_flutter/core/models/devices_token.dart';
import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/language_setting.dart';
import 'package:ottaa_project_flutter/core/models/layout_setting.dart';
import 'package:ottaa_project_flutter/core/models/payment_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/tts_setting.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';

part 'patient_user_model.g.dart';

@HiveType(typeId: HiveTypesIds.patientTypeId)
class PatientUserModel extends UserModel {
  @override
  @HiveField(0)
  String id;

  @HiveField(1)
  Map<String, List<Group>> groups;

  @HiveField(2)
  Map<String, List<Phrase>> phrases;

  @HiveField(3)
  Map<String, List<Picto>> pictos;

  @override
  @HiveField(4)
  UserSettings settings;

  PatientSettings get patientSettings => settings as PatientSettings;

  @override
  @HiveField(5)
  UserType type;

  @override
  @HiveField(6)
  String email;

  @override
  @HiveField(7)
  DeviceToken? currentToken;

  PatientUserModel({
    required this.id,
    required this.groups,
    required this.phrases,
    required this.pictos,
    required this.settings,
    this.type = UserType.user,
    required this.email,
  });

  PatientUserModel copyWith({
    String? id,
    Map<String, List<Group>>? groups,
    Map<String, List<Phrase>>? phrases,
    Map<String, List<Picto>>? pictos,
    PatientSettings? settings,
    UserType? type,
    String? email,
  }) {
    return PatientUserModel(
      id: id ?? this.id,
      groups: groups ?? this.groups,
      phrases: phrases ?? this.phrases,
      pictos: pictos ?? this.pictos,
      settings: settings ?? this.settings,
      type: type ?? this.type,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'groups': groups.map(
        (k, e) => MapEntry(
          k,
          e.map((x) => x.toMap()).toList(),
        ),
      ),
      'phrases': phrases.map(
        (k, e) => MapEntry(
          k,
          e.map((x) => x.toMap()).toList(),
        ),
      ),
      'pictos': pictos.map(
        (k, e) => MapEntry(
          k,
          e.map((x) => x.toMap()).toList(),
        ),
      ),
      'settings': settings.toMap(),
      'type': type.name,
      'email': email
    };
  }

  factory PatientUserModel.fromMap(Map<String, dynamic> map) {
    return PatientUserModel(
      email: "",
      id: map['id'] as String,
      groups: map['groups'] != null
          ? Map<String, List<Group>>.from((map['groups'] as Map<dynamic, dynamic>).map((key, value) {
              return MapEntry<String, List<Group>>(
                key.toString(),
                Map.from(value as dynamic)
                    .values
                    .map<Group>(
                      (e) => Group.fromMap(Map.from(e as dynamic)),
                    )
                    .toList(),
              );
            }))
          : <String, List<Group>>{},
      phrases: map['phrases'] != null && map['phrases'].isNotEmpty
          ? Map<String, List<Phrase>>.from((map['phrases'] as Map<dynamic, dynamic>).map((key, value) {
              return MapEntry<String, List<Phrase>>(
                key.toString(),
                Map.from(value as dynamic)
                    .values
                    .map<Phrase>(
                      (e) => Phrase.fromMap(Map.from(e as dynamic)),
                    )
                    .toList(),
              );
            }))
          : <String, List<Phrase>>{},
      pictos: map['pictos'] != null && map['pictos'].isNotEmpty
          ? Map<String, List<Picto>>.from((map['pictos'] as Map<dynamic, dynamic>).map((key, value) {
              return MapEntry<String, List<Picto>>(
                key.toString(),
                Map.from(value as dynamic)
                    .values
                    .map<Picto>(
                      (e) => Picto.fromMap(Map.from(e as dynamic)),
                    )
                    .toList(),
              );
            }))
          : <String, List<Picto>>{},
      settings: PatientSettings.fromMap(Map.from(map['settings'] as Map<dynamic, dynamic>)),
      type: UserType.values.firstWhere((element) => element.name == map['type'] as String),
    ).copyWith(
      email: map['email'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory PatientUserModel.fromJson(String source) => PatientUserModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'UserModel(id: $id, groups: $groups, phrases: $phrases, pictos: $pictos, settings: $settings, type: $type, email: $email)';
  }

  @override
  bool operator ==(covariant PatientUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && mapEquals(other.groups, groups) && mapEquals(other.phrases, phrases) && mapEquals(other.pictos, pictos) && other.settings == settings && other.type == type && other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ groups.hashCode ^ phrases.hashCode ^ pictos.hashCode ^ settings.hashCode ^ type.hashCode ^ email.hashCode;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) => PatientUserModel.fromMap(json);
}

@HiveType(typeId: HiveTypesIds.patientSettingsTypeId)
class PatientSettings extends UserSettings {
  @override
  @HiveField(0)
  UserData data;

  @override
  @HiveField(1)
  LanguageSetting language;

  @HiveField(2)
  Payment payment;

  @HiveField(3)
  LayoutSetting layout;

  @HiveField(4)
  AccessibilitySetting accessibility;

  @HiveField(5)
  TTSSetting tts;

  PatientSettings({
    required this.data,
    required this.language,
    required this.payment,
    required this.layout,
    required this.accessibility,
    required this.tts,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
      'language': language.toMap(),
      'payment': payment.toMap(),
      'layout': layout.toMap(),
    };
  }

  /// [Deprecated] pastientSettings.language is not more a String
  /// Go to the languageSetting
  ///
  factory PatientSettings.fromMap(Map<String, dynamic> map) {
    return PatientSettings(
      data: UserData.fromMap(Map.from(map['data'] as Map<dynamic, dynamic>)),
      payment: map['payment'] != null ? Payment.fromMap(Map.from(map['payment'] as Map<dynamic, dynamic>)) : Payment.none(),
      layout: map['layout'] != null ? LayoutSetting.fromMap(Map.from(map['layout'] as Map<dynamic, dynamic>)) : LayoutSetting.empty(),
      accessibility: map['accessibility'] != null ? AccessibilitySetting.fromMap(Map.from(map['accessibility'] as Map<dynamic, dynamic>)) : AccessibilitySetting.empty(),
      language: map['language'] != null ? LanguageSetting.fromMap(Map.from(map['language'] as Map<dynamic, dynamic>)) : LanguageSetting.empty(),
      tts: map['tts'] != null ? TTSSetting.fromMap(Map.from(map['tts'] as Map<dynamic, dynamic>)) : TTSSetting.empty(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientSettings.fromJson(String source) => PatientSettings.fromMap(json.decode(source) as Map<String, dynamic>);

  PatientSettings copyWith({
    UserData? data,
    String? language,
    Payment? payment,
    LayoutSetting? layout,
    AccessibilitySetting? accessibility,
    TTSSetting? tts,
    LanguageSetting? languageSetting,
  }) {
    return PatientSettings(
      data: data ?? this.data,
      payment: payment ?? this.payment,
      layout: layout ?? this.layout,
      accessibility: accessibility ?? this.accessibility,
      tts: tts ?? this.tts,
      language: languageSetting ?? this.language,
    );
  }

  @override
  String toString() {
    return 'PatientSettings(data: $data, language: $language, payment: $payment, layout: $layout, accessibility: $accessibility, tts: $tts, languageSetting: $language)';
  }

  @override
  bool operator ==(covariant PatientSettings other) {
    if (identical(this, other)) return true;

    return other.data == data && other.language == language && other.payment == payment && other.layout == layout && other.accessibility == accessibility && other.tts == tts && other.language == language;
  }

  @override
  int get hashCode {
    return data.hashCode ^ language.hashCode ^ payment.hashCode ^ layout.hashCode ^ accessibility.hashCode ^ tts.hashCode ^ language.hashCode;
  }
}
