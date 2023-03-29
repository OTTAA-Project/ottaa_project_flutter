import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

import 'package:ottaa_project_flutter/core/abstracts/user_model.dart';
import 'package:ottaa_project_flutter/core/abstracts/user_settings.dart';
import 'package:ottaa_project_flutter/core/enums/user_types.dart';
import 'package:ottaa_project_flutter/core/models/base_settings_model.dart';
import 'package:ottaa_project_flutter/core/models/devices_token.dart';

part 'base_user_model.g.dart';

@HiveType(typeId: HiveTypesIds.baseUserTypeId)
class BaseUserModel extends UserModel {
  @override
  @HiveField(0)
  String id;

  @override
  @HiveField(3)
  UserSettings settings;

  @override
  @HiveField(5)
  UserType type;

  @override
  @HiveField(6)
  String email;

  @override
  @HiveField(7)
  DeviceToken? currentToken;

  BaseUserModel({
    required this.id,
    required this.settings,
    required this.email,
    this.type = UserType.none,
  });

  @override
  UserModel fromJson(Map<String, dynamic> json) => BaseUserModel(
        id: json['id'],
        settings: BaseSettingsModel.fromMap(json['settings']),
        type: UserType.values.firstWhere((element) => element.name == json['type']),
        email: json['email'] ?? "",
      );

  factory BaseUserModel.fromMap(Map<String, dynamic> json) => BaseUserModel(
        id: json['id'],
        settings: BaseSettingsModel.fromMap(Map.from(json['settings'] as Map<dynamic, dynamic>)),
        type: UserType.values.firstWhere((element) => element.name == json['type']),
        email: json['email'] ?? "",
      );

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'settings': settings.toMap(),
        'type': type.name,
      };

  UserModel copyWith(other) {
    return BaseUserModel(
      id: other.id ?? id,
      settings: other.settings ?? settings,
      type: other.type ?? type,
      email: other.email ?? email,
    );
  }
}
