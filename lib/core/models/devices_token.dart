import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';

@HiveType(typeId: HiveTypesIds.userDeviceTypeId)
class DeviceToken {
  @HiveField(0)
  final String deviceToken;
  @HiveField(1)
  DateTime lastUsage;

  DeviceToken({
    required this.deviceToken,
    required this.lastUsage,
  });

  DeviceToken copyWith({
    String? deviceToken,
    DateTime? lastUsage,
  }) {
    return DeviceToken(
      deviceToken: deviceToken ?? this.deviceToken,
      lastUsage: lastUsage ?? this.lastUsage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceToken': deviceToken,
      'lastUsage': lastUsage.millisecondsSinceEpoch,
    };
  }

  factory DeviceToken.fromMap(Map<String, dynamic> map) {
    return DeviceToken(
      deviceToken: map['deviceToken'] as String,
      lastUsage: DateTime.fromMillisecondsSinceEpoch(map['lastUsage'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceToken.fromJson(String source) => DeviceToken.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DeviceToken(deviceToken: $deviceToken, lastUsage: $lastUsage)';

  @override
  bool operator ==(covariant DeviceToken other) {
    if (identical(this, other)) return true;

    return other.deviceToken == deviceToken;
  }

  @override
  int get hashCode => deviceToken.hashCode;
}
