// coverage:ignore-file

import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:ottaa_project_flutter/core/abstracts/hive_type_ids.dart';
import 'package:ottaa_project_flutter/core/enums/devices_accessibility.dart';
import 'package:ottaa_project_flutter/core/enums/sweep_modes.dart';
import 'package:ottaa_project_flutter/core/enums/velocity_types.dart';

part 'accessibility_setting.g.dart';

@HiveType(typeId: HiveTypesIds.accessibilityTypeId)
class AccessibilitySetting {
  @HiveField(0, defaultValue: DevicesAccessibility.none)
  DevicesAccessibility device;

  @HiveField(1, defaultValue: SweepModes.elements)
  SweepModes sweepMode;

  @HiveField(2, defaultValue: VelocityTypes.mid)
  VelocityTypes sweepSpeed;

  @HiveField(3, defaultValue: VelocityTypes.mid)
  VelocityTypes clickTime;
  AccessibilitySetting({
    required this.device,
    required this.sweepMode,
    required this.sweepSpeed,
    required this.clickTime,
  });

  AccessibilitySetting copyWith({
    DevicesAccessibility? device,
    SweepModes? sweepMode,
    VelocityTypes? sweepSpeed,
    VelocityTypes? clickTime,
  }) {
    return AccessibilitySetting(
      device: device ?? this.device,
      sweepMode: sweepMode ?? this.sweepMode,
      sweepSpeed: sweepSpeed ?? this.sweepSpeed,
      clickTime: clickTime ?? this.clickTime,
    );
  }

  factory AccessibilitySetting.empty() {
    return AccessibilitySetting(
      device: DevicesAccessibility.none,
      sweepMode: SweepModes.elements,
      sweepSpeed: VelocityTypes.mid,
      clickTime: VelocityTypes.mid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'device': device.name,
      'sweepMode': sweepMode.name,
      'sweepSpeed': sweepSpeed.name,
      'clickTime': clickTime.name,
    };
  }

  factory AccessibilitySetting.fromMap(Map<String, dynamic> map) {
    return AccessibilitySetting(
      device: DevicesAccessibility.values.firstWhere(
        (e) => e.name == map['device'].toString(),
        orElse: () => DevicesAccessibility.none,
      ),
      sweepMode: SweepModes.values.firstWhere(
        (e) => e.name == map['sweepMode'].toString(),
        orElse: () => SweepModes.elements,
      ),
      sweepSpeed: VelocityTypes.values.firstWhere(
        (e) => e.name == map['sweepSpeed'].toString(),
        orElse: () => VelocityTypes.mid,
      ),
      clickTime: VelocityTypes.values.firstWhere(
        (e) => e.name == map['clickTime'].toString(),
        orElse: () => VelocityTypes.mid,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AccessibilitySetting.fromJson(String source) =>
      AccessibilitySetting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccessibilitySetting(device: $device, sweepMode: $sweepMode, sweepSpeed: $sweepSpeed, clickTime: $clickTime)';
  }

  @override
  bool operator ==(covariant AccessibilitySetting other) {
    if (identical(this, other)) return true;

    return other.device == device &&
        other.sweepMode == sweepMode &&
        other.sweepSpeed == sweepSpeed &&
        other.clickTime == clickTime;
  }

  @override
  int get hashCode {
    return device.hashCode ^
        sweepMode.hashCode ^
        sweepSpeed.hashCode ^
        clickTime.hashCode;
  }
}
