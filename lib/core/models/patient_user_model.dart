import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_settings.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';

import 'package:ottaa_project_flutter/core/models/group_model.dart';
import 'package:ottaa_project_flutter/core/models/payment_model.dart';
import 'package:ottaa_project_flutter/core/models/phrase_model.dart';
import 'package:ottaa_project_flutter/core/models/picto_model.dart';
import 'package:ottaa_project_flutter/core/models/shortcuts_model.dart';

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
    };
  }

  factory PatientUserModel.fromMap(Map<String, dynamic> map) {
    if (map['groups'].isEmpty) {
      print('yes');
    }
    return PatientUserModel(
      email: "",
      id: map['id'] as String,
      groups:
          // <String, List<Group>>{},
          map['groups'] != null && map['groups'].isNotEmpty
              ? Map<String, List<Group>>.fromIterables(
                  map['groups'].keys,
                  map['groups'].values.map(
                    (e) {
                      return List<Group>.from(
                        e.map(
                          (x) {
                            return Group.fromMap(x as Map<String, dynamic>);
                          },
                        ),
                      );
                    },
                  ),
                )
              : <String, List<Group>>{},
      phrases:
          // <String, List<Phrase>>{},
          map['phrases'] != null&& map['phrases'].isNotEmpty
              ? Map<String, List<Phrase>>.fromIterables(
                  map['phrases'].keys,
                  map['groups'].values.map(
                        (e) => List<Phrase>.from(
                          e.map(
                              (x) => Phrase.fromMap(x as Map<String, dynamic>)),
                        ),
                      ),
                )
              : <String, List<Phrase>>{},
      pictos:
          // <String, List<Picto>>{},
          map['pictos'] != null&& map['pictos'].isNotEmpty
              ? Map<String, List<Picto>>.fromIterables(
                  map['pictos'].keys,
                  map['pictos'].values.map(
                        (e) => List<Picto>.from(
                          e.map(
                              (x) => Picto.fromMap(x as Map<String, dynamic>)),
                        ),
                      ),
                )
              : <String, List<Picto>>{},
      settings: PatientSettings.fromMap(
          Map.from(map['settings'] as Map<dynamic, dynamic>)),
      type: UserType.values
          .firstWhere((element) => element.name == map['type'] as String),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory PatientUserModel.fromJson(String source) => PatientUserModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'UserModel(id: $id, groups: $groups, phrases: $phrases, pictos: $pictos, settings: $settings, type: $type)';
  }

  @override
  bool operator ==(covariant PatientUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        mapEquals(other.groups, groups) &&
        mapEquals(other.phrases, phrases) &&
        mapEquals(other.pictos, pictos) &&
        other.settings == settings &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        groups.hashCode ^
        phrases.hashCode ^
        pictos.hashCode ^
        settings.hashCode ^
        type.hashCode;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) =>
      PatientUserModel.fromMap(json);
}

@HiveType(typeId: HiveTypesIds.patientSettingsTypeId)
class PatientSettings extends UserSettings {
  @override
  @HiveField(0)
  UserData data;

  @override
  @HiveField(1)
  String language;

  @HiveField(2)
  Payment payment;

  @HiveField(3)
  Shortcuts shortcuts;

  PatientSettings({
    required this.data,
    required this.language,
    required this.payment,
    required this.shortcuts,
  });

  PatientSettings copyWith({
    UserData? data,
    String? language,
    Payment? payment,
    Shortcuts? shortcuts,
  }) {
    return PatientSettings(
      data: data ?? this.data,
      language: language ?? this.language,
      payment: payment ?? this.payment,
      shortcuts: shortcuts ?? this.shortcuts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
      'language': language,
      'payment': payment.toMap(),
      'shortcuts': shortcuts.toMap(),
    };
  }

  factory PatientSettings.fromMap(Map<String, dynamic> map) {
    return PatientSettings(
      data: UserData.fromMap(Map.from(map['data'] as Map<dynamic, dynamic>)),
      language: map['language'] as String,
      payment: map['payment'] != null
          ? Payment.fromMap(Map.from(map['payment'] as Map<dynamic, dynamic>))
          : Payment.none(),
      shortcuts: map['shortcuts'] != null
          ? Shortcuts.fromMap(
              Map.from(map['shortcuts'] as Map<dynamic, dynamic>))
          : Shortcuts.none(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientSettings.fromJson(String source) =>
      PatientSettings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Settings(data: $data, language: $language, payment: $payment, shortcuts: $shortcuts)';
  }

  @override
  bool operator ==(covariant PatientSettings other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.language == language &&
        other.payment == payment &&
        other.shortcuts == shortcuts;
  }

  @override
  int get hashCode {
    return data.hashCode ^
        language.hashCode ^
        payment.hashCode ^
        shortcuts.hashCode;
  }
}
