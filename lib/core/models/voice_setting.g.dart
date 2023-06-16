// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of 'voice_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VoiceSettingAdapter extends TypeAdapter<VoiceSetting> {
  @override
  final int typeId = 27;

  @override
  VoiceSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VoiceSetting(
      voicesNames:
          fields[0] == null ? {} : (fields[0] as Map).cast<String, String>(),
      voicesSpeed: fields[1] == null
          ? {}
          : (fields[1] as Map).cast<String, VelocityTypes>(),
      mutePict: fields[2] == null ? false : fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, VoiceSetting obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.voicesNames)
      ..writeByte(1)
      ..write(obj.voicesSpeed)
      ..writeByte(2)
      ..write(obj.mutePict);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoiceSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
