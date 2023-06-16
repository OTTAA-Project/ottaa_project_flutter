// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of 'subtitles_setting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubtitlesSettingAdapter extends TypeAdapter<SubtitlesSetting> {
  @override
  final int typeId = 28;

  @override
  SubtitlesSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubtitlesSetting(
      show: fields[0] == null ? false : fields[0] as bool,
      size: fields[1] == null ? SizeTypes.mid : fields[1] as SizeTypes,
      caps: fields[2] == null ? false : fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SubtitlesSetting obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.show)
      ..writeByte(1)
      ..write(obj.size)
      ..writeByte(2)
      ..write(obj.caps);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtitlesSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
