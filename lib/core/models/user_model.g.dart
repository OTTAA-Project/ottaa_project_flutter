// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      birthdate: json['birthdate'] as int?,
      gender: json['gender'] as String?,
      language: json['language'] as String? ?? 'es',
      isFirstTime: json['isFirstTime'] as bool? ?? true,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'birthdate': instance.birthdate,
      'gender': instance.gender,
      'language': instance.language,
      'isFirstTime': instance.isFirstTime,
    };
