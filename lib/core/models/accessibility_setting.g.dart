// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of 'accessibility_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccessibilitySettingAdapter extends TypeAdapter<AccessibilitySetting> {
  @override
  final int typeId = 26;

  @override
  AccessibilitySetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccessibilitySetting(
      device: fields[0] == null
          ? DevicesAccessibility.none
          : fields[0] as DevicesAccessibility,
      sweepMode:
          fields[1] == null ? SweepModes.elements : fields[1] as SweepModes,
      sweepSpeed:
          fields[2] == null ? VelocityTypes.mid : fields[2] as VelocityTypes,
      clickTime:
          fields[3] == null ? VelocityTypes.mid : fields[3] as VelocityTypes,
    );
  }

  @override
  void write(BinaryWriter writer, AccessibilitySetting obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.device)
      ..writeByte(1)
      ..write(obj.sweepMode)
      ..writeByte(2)
      ..write(obj.sweepSpeed)
      ..writeByte(3)
      ..write(obj.clickTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessibilitySettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
