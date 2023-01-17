import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/models/assets_image.dart';

part 'user_data_model.g.dart';

@HiveType(typeId: HiveTypesIds.userDataTypeId)
class UserData {
  @HiveField(0)
  final AssetsImage avatar;

  @HiveField(1)
  final DateTime birthDate;

  @HiveField(2)
  final String genderPref;

  @HiveField(3)
  final DateTime lastConnection;

  @HiveField(4)
  final String lastName;

  @HiveField(5)
  final String name;

  @HiveField(6, defaultValue: "")
  final String? number;

  const UserData({
    required this.avatar,
    required this.birthDate,
    required this.genderPref,
    required this.lastConnection,
    required this.lastName,
    required this.name,
    this.number = "",
  });

  UserData copyWith({
    AssetsImage? avatar,
    DateTime? birthDate,
    String? genderPref,
    DateTime? lastConnection,
    String? lastName,
    String? name,
    String? number,
  }) {
    return UserData(
      avatar: avatar ?? this.avatar,
      birthDate: birthDate ?? this.birthDate,
      genderPref: genderPref ?? this.genderPref,
      lastConnection: lastConnection ?? this.lastConnection,
      lastName: lastName ?? this.lastName,
      name: name ?? this.name,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'avatar': avatar.toMap(),
      'birthDate': birthDate.millisecondsSinceEpoch,
      'genderPref': genderPref,
      'lastConnection': lastConnection.millisecondsSinceEpoch,
      'lastName': lastName,
      'name': name,
      'number': number,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      avatar: AssetsImage.fromMap(Map.from(map['avatar'] as Map<dynamic, dynamic>)),
      birthDate: DateTime.fromMillisecondsSinceEpoch(map['birthDate'] as int),
      genderPref: map['genderPref'] as String,
      lastConnection: DateTime.fromMillisecondsSinceEpoch(map['lastConnection'] as int),
      lastName: map['lastName'] as String,
      name: map['name'] as String,
      number: map['number'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserData(avatar: $avatar, birthDate: $birthDate, genderPref: $genderPref, lastConnection: $lastConnection, lastName: $lastName, name: $name, number: $number)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.avatar == avatar && other.birthDate == birthDate && other.genderPref == genderPref && other.lastConnection == lastConnection && other.lastName == lastName && other.name == name && other.number == number;
  }

  @override
  int get hashCode {
    return avatar.hashCode ^ birthDate.hashCode ^ genderPref.hashCode ^ lastConnection.hashCode ^ lastName.hashCode ^ name.hashCode ^ number.hashCode;
  }
}
