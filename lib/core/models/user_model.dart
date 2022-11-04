import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final int? birthdate;
  final String? gender;
  final String? language;
  final bool isFirstTime;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.birthdate,
    this.gender,
    this.language = 'es',
    this.isFirstTime = true,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
