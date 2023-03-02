// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/enums/velocity_types.dart';

part 'voice_setting.g.dart';

typedef VoicesNames = Map<String, String>;

typedef VoicesSpeed = Map<String, VelocityTypes>;

@HiveType(typeId: HiveTypesIds.voiceAccessibilityTypeId)
class VoiceSetting {
  @HiveField(0, defaultValue: {})
  VoicesNames voicesNames;

  @HiveField(1, defaultValue: {})
  VoicesSpeed voicesSpeed;

  @HiveField(2, defaultValue: false)
  bool mutePict;
  VoiceSetting({
    required this.voicesNames,
    required this.voicesSpeed,
    required this.mutePict,
  });

  factory VoiceSetting.empty() {
    return VoiceSetting(
      voicesNames: {},
      voicesSpeed: {},
      mutePict: false,
    );
  }

  VoiceSetting copyWith({
    VoicesNames? voicesNames,
    VoicesSpeed? voicesSpeed,
    bool? mutePict,
  }) {
    return VoiceSetting(
      voicesNames: voicesNames ?? this.voicesNames,
      voicesSpeed: voicesSpeed ?? this.voicesSpeed,
      mutePict: mutePict ?? this.mutePict,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': voicesNames,
      'speed': voicesSpeed,
      'mutePict': mutePict,
    };
  }

  factory VoiceSetting.fromMap(Map<String, dynamic> map) {
    return VoiceSetting(
      voicesNames: Map.from(map['name'] as dynamic),
      voicesSpeed: Map.from(map['speed'] as dynamic).map((key, value) {
        return MapEntry(key, VelocityTypes.values.firstWhere((element) => element.name == value.toString(), orElse: () => VelocityTypes.mid));
      }),
      mutePict: map['mutePict'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory VoiceSetting.fromJson(String source) => VoiceSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VoiceAccessibilitySetting(name: $voicesNames, speed: $voicesSpeed, mutePict: $mutePict)';

  @override
  bool operator ==(covariant VoiceSetting other) {
    if (identical(this, other)) return true;

    return other.voicesNames == voicesNames && other.voicesSpeed == voicesSpeed && other.mutePict == mutePict;
  }

  @override
  int get hashCode => voicesNames.hashCode ^ voicesSpeed.hashCode ^ mutePict.hashCode;
}
