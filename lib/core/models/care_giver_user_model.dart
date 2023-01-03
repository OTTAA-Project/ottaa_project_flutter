import 'package:json_annotation/json_annotation.dart';

part 'care_giver_user_model.g.dart';

@JsonSerializable()
class CareGiverUser {
  final String alias;
  @JsonKey(name: 'user-id')
  final String userId;

  const CareGiverUser({
    required this.alias,
    required this.userId,
  });

  factory CareGiverUser.fromJson(Map<String, dynamic> json) =>
      _$CareGiverUserFromJson(json);

  Map<String, dynamic> toJson() => _$CareGiverUserToJson(this);
}
