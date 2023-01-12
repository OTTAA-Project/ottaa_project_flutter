// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_settings.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/user_data_model.dart';

part 'caregiver_user_model.g.dart';

@HiveType(typeId: HiveTypesIds.caregiverUserTypeId)
class CaregiverUserModel extends UserModel {
  @override
  @HiveField(0)
  String id;

  @override
  @HiveField(1)
  UserSettings settings;

  @override
  @HiveField(2)
  final UserType type;

  @HiveField(3)
  final Map<String, CaregiverUsers> users;

  @override
  @HiveField(4)
  String email;

  CaregiverUserModel({
    required this.id,
    required this.settings,
    this.type = UserType.none,
    required this.users,
    required this.email,
  });

  @override
  CaregiverUserModel copyWith({
    String? id,
    BaseSettingsModel? settings,
    UserType? type,
    Map<String, CaregiverUsers>? users,
    String? email,
  }) {
    return CaregiverUserModel(
      id: id ?? this.id,
      settings: settings ?? this.settings,
      type: type ?? this.type,
      users: users ?? this.users,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'settings': settings.toMap(),
      'type': type.name,
      'users': users,
      'email': email,
    };
  }

  factory CaregiverUserModel.fromMap(Map<String, dynamic> map) {
    return CaregiverUserModel(
      id: map['id'] as String,
      settings: BaseSettingsModel.fromMap(map['settings'] as Map<String, dynamic>),
      type: UserType.caregiver,
      users: Map<String, CaregiverUsers>.from((map['users'] as Map<String, CaregiverUsers>)),
      email: map['email'] as String,
    );
  }

  factory CaregiverUserModel.fromJson(String source) => CaregiverUserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CaregiverUserModel(id: $id, settings: $settings, type: $type, users: $users, email: $email)';
  }

  @override
  bool operator ==(covariant CaregiverUserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.settings == settings && other.type == type && mapEquals(other.users, users) && other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ settings.hashCode ^ type.hashCode ^ users.hashCode ^ email.hashCode;
  }

  @override
  UserModel fromJson(Map<String, dynamic> json) => CaregiverUserModel.fromMap(json);

  @override
  String toJson() => json.encode(toMap());
}

@HiveType(typeId: HiveTypesIds.caregiverUsersTypeId)
class CaregiverUsers {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  const CaregiverUsers({
    required this.id,
    required this.name,
  });

  CaregiverUsers copyWith({
    String? id,
    String? name,
  }) {
    return CaregiverUsers(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory CaregiverUsers.fromMap(Map<String, dynamic> map) {
    return CaregiverUsers(
      name: map['name'] as String,
      id: "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CaregiverUsers.fromJson(String source) => CaregiverUsers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CaregiverUsers(name: $name)';

  @override
  bool operator ==(covariant CaregiverUsers other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
